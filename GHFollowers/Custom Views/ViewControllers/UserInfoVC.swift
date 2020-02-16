//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 19/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

protocol UserInfoDelegate: class {
    func showFollowers(for username: String)
}

class UserInfoVC: UIViewController {
    
    // MARK: - Properties
    
    var follower: Follower
    var user: User?
    weak var delegate: UserInfoDelegate?
    
    // MARK: - Subviews
    
    @Constrainted var headerView = UIView()
    @Constrainted var firstInfoView = UIView()
    @Constrainted var secondInfoView = UIView()
    @Constrainted var dateLabel = GFBodyLabel(textAlignment: .center)
    
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
                    self.dateLabel.text = "GitHub since \(user.createdAt.convertToMonthAndYear())"
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func setupLayout() {
        
        let padding: CGFloat = 28
        view.addSubview(headerView)
        view.addAndStretch(with: padding, firstInfoView, secondInfoView, dateLabel)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),
            headerView.leadingAnchor.constraint(equalTo: firstInfoView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            firstInfoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            firstInfoView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2),
            secondInfoView.topAnchor.constraint(equalTo: firstInfoView.bottomAnchor, constant: padding),
            secondInfoView.heightAnchor.constraint(equalTo: firstInfoView.heightAnchor, multiplier: 1.0),
            dateLabel.topAnchor.constraint(equalTo: secondInfoView.bottomAnchor, constant: padding),
        ])
    }
    
    private func addUserInfoControllers(withUser user: User) {
        add(viewController: UserHeaderVC(user: user), toView: headerView)
        add(viewController: GFRepoItemVC(with: user, delegate: self), toView: firstInfoView)
        add(viewController: GFFollowersItemVC(with: user, delegate: self), toView: secondInfoView)
    }
    
    private func add(viewController vc: UIViewController, toView view: UIView) {
        addChild(vc)
        vc.view.frame = view.bounds
        view.addSubview(vc.view)
        vc.didMove(toParent: self)
    }
    
}

extension UserInfoVC: ProfileTappable {
    func tappedProfileButton(with user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "Error", message: "user url couldn't be loaded", buttonTitle: "OK")
            return
        }
        showSafariVC(for: url)
    }
}

extension UserInfoVC: FollowersTappable {
    func getFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(title: "No followers", message: "This user doesn't have any followers 😞.", buttonTitle: "OK")
            return
        }
        
        delegate?.showFollowers(for: user.login)
        dismissVC()
    }
}
