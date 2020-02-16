//
//  FavouriteCell.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 10/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class FavouriteCell: UITableViewCell {
    
    fileprivate let padding: CGFloat = 22
    
    @Constrainted private var avatarImageView = GFAvatarImageView(frame: .zero)
    @Constrainted private var loginLabel = GFTitleLabel(textAlignment: .left, fontSize: 28)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        avatarImageView.downloadImage(fromURL: follower.avatarUrl)
        loginLabel.text = follower.login
    }
    
    private func layoutCell() {
        contentView.addSubviews(avatarImageView, loginLabel)
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            avatarImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            loginLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding),
            loginLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding / 2.0),
            loginLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor)
        ])
    }
    
}
