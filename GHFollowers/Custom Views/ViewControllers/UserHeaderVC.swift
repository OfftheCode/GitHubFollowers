//
//  UserHeaderVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 26/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class UserHeaderVC: UIViewController {
    
    // MARK: - Properties
    
    let user: User
    let nameFontSize: CGFloat = 18
    
    // MARK: - Subviews
    
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameTitleLabel = GFTitleLabel(textAlignment: .left, fontSize: 30)
    lazy var nameSubtitleLabel = GFSubtitleLabel(fontSize: nameFontSize)
    let locationImageView = UIImageView(image: SFSymbol.pinIcon)
    let locationSubtitleLabel = GFSubtitleLabel(fontSize: 18)
    let bioBodyLabel = GFBodyLabel(textAlignment: .left)
    
    // MARK: - Init
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupData()
    }
    
    private func setupLayout() {
        view.addSubviews(
            avatarImageView,
            usernameTitleLabel,
            nameSubtitleLabel,
            locationImageView,
            locationSubtitleLabel,
            bioBodyLabel
        )
        
        locationImageView.tintColor = .label
        
        let bigPadding: CGFloat = 28
        let mediumPadding: CGFloat = 16
        let smallPadding: CGFloat = 6
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: bigPadding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            avatarImageView.widthAnchor.constraint(equalToConstant: 100),
            
            usernameTitleLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameTitleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: mediumPadding),
            usernameTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: mediumPadding),
            
            nameSubtitleLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: nameFontSize / 2.0),
            nameSubtitleLabel.leadingAnchor.constraint(equalTo: usernameTitleLabel.leadingAnchor),
            
            locationImageView.leadingAnchor.constraint(equalTo: nameSubtitleLabel.leadingAnchor),
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.heightAnchor.constraint(equalToConstant: 24),
            locationImageView.widthAnchor.constraint(equalToConstant: 24),
            
            locationSubtitleLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: smallPadding),
            locationSubtitleLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            
            bioBodyLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: bigPadding),
            bioBodyLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioBodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupData() {
        avatarImageView.downloadImage(from: user.avatarUrl)
        usernameTitleLabel.text = user.login
        nameSubtitleLabel.text = user.name
        locationSubtitleLabel.text = user.location ?? "Unknow"
        bioBodyLabel.text = user.bio ?? "No bio avilable."
    }
    
}
