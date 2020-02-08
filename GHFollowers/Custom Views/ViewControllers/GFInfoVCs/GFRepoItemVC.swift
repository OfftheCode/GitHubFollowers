//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 08/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

protocol ProfileTappable: class {
    func tappedProfileButton(with user: User)
}

class GFRepoItemVC: GFInfoItemVC {
    
    weak var delegate: ProfileTappable?
    
    init(with user: User, delegate: ProfileTappable? = nil) {
        self.delegate = delegate
        super.init(with: user)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        leftInfoView.setInfoStyle(.repos, count: user.publicRepos)
        rightInfoView.setInfoStyle(.gitsts, count: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
    override func buttonTapped() {
        delegate?.tappedProfileButton(with: user)
    }
    
}
