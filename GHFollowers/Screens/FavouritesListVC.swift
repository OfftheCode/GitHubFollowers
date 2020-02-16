//
//  FavouritesVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 03/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class FavouritesListVC: UIViewController, Loadable {
    var containerView: UIView!
    
    // MARK: - Properties
    
    var favourites = [Follower]() {
        didSet {
            view.bringSubviewToFront(tableView)
            tableView.isHidden = false
        }
    }
    
    // MARK: - Subviews
    
    @Constrainted private var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
        tableView.reloadData()
    }
    
    private func configureVC() {
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
        tableView.rowHeight = 80
        tableView.removeExcessCells()
    }
    
    private func setupLayout() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func getFavourites() {
        PersistanceManager.retriveFavoruites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Couldn't fetch favourites", message: error.rawValue, buttonTitle: "OK")
                self.showEmptyStateView(with: "Couldn't fetch favourites", in: self.view)
            case .success(let favourites):
                guard !favourites.isEmpty else {
                    self.showEmptyState()
                    return
                }
                self.favourites = favourites
            }
        }
    }
    
    fileprivate func showEmptyState() {
        showEmptyStateView(with: "You don't have any favourites yet, go and favourite them!", in: self.view)
        tableView.isHidden = true
    }
    
}

extension FavouritesListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favourites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let favouriteCell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseID, for: indexPath) as! FavouriteCell
        favouriteCell.set(follower: favourites[indexPath.row])
        return favouriteCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favourite = favourites[indexPath.row]
        let followersVC = FollowersListVC()
        followersVC.username = favourite.login
        navigationController?.pushViewController(followersVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete,
            let favouriteToBeRemoved = favourites[safe: indexPath.row] else { return }
        
        PersistanceManager.updateFavourites(with: favouriteToBeRemoved, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favourites.removeAll { $0 == favouriteToBeRemoved }
                tableView.deleteRows(at: [indexPath], with: .automatic)
                if self.favourites.isEmpty { self.showEmptyState() }
                return
            }
            self.presentGFAlertOnMainThread(title: "Error while removing", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
}
