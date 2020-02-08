//
//  GFFollowersItemVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 08/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

protocol FollowersTappable: class {
    func getFollowers(for user: User)
}

class GFFollowersItemVC: GFInfoItemVC {
    
    weak var delegate: FollowersTappable?
    
    init(with user: User, delegate: FollowersTappable? = nil) {
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
        leftInfoView.setInfoStyle(.following, count: user.following)
        rightInfoView.setInfoStyle(.followers, count: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
    override func buttonTapped() {
        delegate?.getFollowers(for: user)
    }
    
}
