//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 04/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class FollowersListVC: UIViewController {
 
    var username: String! {
        willSet {
            configure(with: newValue)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: username, page: 1) { [unowned self] followers, errorMessage in
            guard let followers = followers else {
                self.presentGFAlertOnMainThread(title: "Error", message: errorMessage ?? "Something went wrong", buttonTitle: "OK")
                return
            }
            
            print("Followers count = \(followers.count)")
            print(followers)
        }
    }

    private func configure(with username: String) {
        title = username
        // further configuration ...
    }
    
}
