//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 08/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFInfoItemVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        leftInfoView.setInfoStyle(.repos, count: user.publicRepos)
        rightInfoView.setInfoStyle(.gitsts, count: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "Github Profile")
    }
    
}
