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
    
    @Constrainted var headerView = UIView()
    @Constrainted var firstInfoView = UIView()
    @Constrainted var secondInfoView = UIView()
    
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
                    self.addUserInfoControllers(withUser: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func setupLayout() {
        
        let padding: CGFloat = 28
        view.addSubview(headerView)
        view.addAndStretch(with: padding, firstInfoView, secondInfoView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            headerView.leadingAnchor.constraint(equalTo: firstInfoView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            firstInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            secondInfoView.topAnchor.constraint(equalTo: firstInfoView.bottomAnchor, constant: padding),
            secondInfoView.heightAnchor.constraint(equalTo: firstInfoView.heightAnchor, multiplier: 1.0)
        ])
    }
    
    private func addUserInfoControllers(withUser user: User) {
        add(viewController: UserHeaderVC(user: user), toView: view)
        add(viewController: GFRepoItemVC(with: user), toView: firstInfoView)
        add(viewController: GFFollowersItemVC(with: user), toView: secondInfoView)
    }
    
    private func add(viewController vc: UIViewController, toView view: UIView) {
        addChild(vc)
        vc.view.frame = view.bounds
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}
