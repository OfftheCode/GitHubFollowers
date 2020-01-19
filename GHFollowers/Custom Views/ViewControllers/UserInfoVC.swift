//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 19/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var follower: Follower
    var user: User?
    
    init(with follower: Follower) {
        self.follower = follower
        super.init(nibName: nil, bundle: nil)
        fetchUser()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureNavigation()
    }
    
    private func configureNavigation() {
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        navigationItem.title = follower.login
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }

    
    private func fetchUser() {
        NetworkManager.shared.getUserInfo(with: follower.login) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                print(user)
                self.user = user
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
}
