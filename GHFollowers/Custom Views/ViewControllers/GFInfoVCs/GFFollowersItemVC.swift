//
//  GFFollowersItemVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 08/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFFollowersItemVC: GFInfoItemVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        leftInfoView.setInfoStyle(.following, count: user.following)
        rightInfoView.setInfoStyle(.followers, count: user.followers)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    
}
