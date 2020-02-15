//
//  GFTabBarController.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 15/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        viewControllers = [createSearchNC(), createFavouritesNC()]
    }
    
    private func setupAppearance() {
        UITabBar.appearance().tintColor = .systemGreen
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    private func createSearchNC() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.title = "Search"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: searchVC)
    }
    
    private func createFavouritesNC() -> UINavigationController {
        let favouritesVC = FavouritesListVC()
        favouritesVC.title = "Favourites"
        favouritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouritesVC)
    }
    
}
