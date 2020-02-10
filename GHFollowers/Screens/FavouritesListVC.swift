//
//  FavouritesVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 03/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class FavouritesListVC: UIViewController {
    
    // MARK: - Properties
    
    var favourites = [Follower]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    // MARK: - Subviews
    
    @Constrainted private var tableView = UITableView()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavourites()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureTableView()
        setupLayout()
    }
    
    private func configureVC() {
        title = "Favourites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseID)
        tableView.rowHeight = 80
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
                    self.showEmptyStateView(with: "You don't have any favourites yet, go and favourite them!", in: self.view)
                    return
                }
                self.favourites = favourites
            }
        }
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
    
    
}
