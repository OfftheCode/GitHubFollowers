//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 04/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController, Loadable {
    var containerView: UIView!
 
    enum Section {
        case main
    }
    
    var username: String! {
        willSet {
            configure(with: newValue)
        }
    }
    
    var isSearching: Bool { !filteredFollowers.isEmpty }
    
    var followers: [Follower] = []
    var filteredFollowers: [Follower] = []
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page: Int = 1
    var hasMoreFollowers = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getFollowers(page: 1)
    }

    private func configure(with username: String) {
        title = username
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        let addBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addToFavourites))
        navigationItem.rightBarButtonItem = addBarButton
    }
    
    @objc private func addToFavourites() {
        NetworkManager.shared.getUserInfo(with: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            case .success(let user):
                self.addUserToFavourites(user)
            }
        }
    }
    
    private func addUserToFavourites(_ user: User) {
        let follower = Follower(from: user)
        PersistanceManager.updateFavourites(with: follower, actionType: .save) { error in
            
            if let error = error {
                self.presentGFAlertOnMainThread(title: "Already Favourited", message: error.rawValue, buttonTitle: "OK", style: .info)
            } else {
                self.presentGFAlertOnMainThread(title: "Success!", message: "You have successfully favourited this user 🎉", buttonTitle: "Hooray", style: .success)
            }
        }
        
    }
    
    private func configureSearchController() {
        let searchVC = UISearchController()
        searchVC.searchResultsUpdater = self
        searchVC.searchBar.placeholder = "nickname"
        searchVC.obscuresBackgroundDuringPresentation = false
        searchVC.searchBar.delegate = self
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchVC
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func getFollowers(page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] result in
            guard let self = self else { return }
            self.hideLoadingView()
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        
        if self.followers.isEmpty {
            DispatchQueue.main.async {
                self.showEmptyStateView(with: "This user doesn't have any followers. Go follow them 😀.", in: self.view)
            }
            return
        }
        
        self.updateData(for: self.followers)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData(for followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers, toSection: .main)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y // currentOffset Y
        let contentHeight = scrollView.contentSize.height // full height of content inside scroll
        let height = scrollView.frame.size.height // screen size
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let currentFollowers = isSearching ? filteredFollowers : followers
        let selectedFollower = currentFollowers[indexPath.item]
        
        let userInfoVC = UserInfoVC(with: selectedFollower)
        userInfoVC.delegate = self
        let userNavigationController = UINavigationController(rootViewController: userInfoVC)
        
        present(userNavigationController, animated: true)
    }
    
}


extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(for: followers)
            return
        }
        
        filteredFollowers = followers.filter { follower in
            follower.login.contains(filter)
        }
        
        updateData(for: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        updateData(for: followers)
    }
}

extension FollowersListVC: UserInfoDelegate {
    
    func showFollowers(for username: String) {
        self.username = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(page: page)
    }
    
}
