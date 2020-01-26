//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 19/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    
    var follower: Follower
    var user: User?
    
    // MARK: - Subviews
    
    let headerView = UIView()
    let firstInfoView = UIView()
    let secondInfoView = UIView()
    
    // MARK: - Lifecycle
    
    init(with follower: Follower) {
        self.follower = follower
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Coder not implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayout()
        configureNavigation()
        fetchUser()
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
                self.user = user
                DispatchQueue.main.async {
                    self.addUserVC(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func setupLayout() {
        
        let padding: CGFloat = 28
        
        view.addAndStretch(with: padding, headerView, firstInfoView, secondInfoView)
        
        firstInfoView.backgroundColor = .systemBlue
        secondInfoView.backgroundColor = .systemPink
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            firstInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.22),
            secondInfoView.topAnchor.constraint(equalTo: firstInfoView.bottomAnchor, constant: padding),
            secondInfoView.heightAnchor.constraint(equalTo: firstInfoView.heightAnchor, multiplier: 1.0)
        ])
    }
    
    private func addUserVC(with user: User) {
        let userVC = UserHeaderVC(user: user)
        addChild(userVC)
        userVC.view.frame = headerView.bounds
        headerView.addSubview(userVC.view)
        userVC.didMove(toParent: self)
    }
    
}
