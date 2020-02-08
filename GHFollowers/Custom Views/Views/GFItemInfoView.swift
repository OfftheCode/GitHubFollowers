//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 01/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFItemInfoView: UIView {
    
    // MARK: - Views
    
    let iconView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 18)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 18)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        layoutUI()
    }
    
    convenience init(itemInfoStyle: ItemInfoStyle, count: Int) {
        self.init(frame: .zero)
        setInfoStyle(itemInfoStyle, count: count)
    }
    
    private func configureViews() {
        iconView.tintColor = .label
        iconView.contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented!")
    }
    
    private func layoutUI() {
        addSubviews(iconView, titleLabel, countLabel)
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            countLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }
    
    func setInfoStyle(_ item: ItemInfoStyle, count: Int) {
        iconView.image = item.image
        titleLabel.text = item.title
        countLabel.text = String(count)
    }
}

enum ItemInfoStyle {
    case repos, gitsts, following, followers
    
    var image: UIImage? {
        switch self {
        case .repos:
            return SFSymbol.reposIcon
        case .gitsts:
            return SFSymbol.gistsIcon
        case .following:
            return SFSymbol.followingIcon
        case .followers:
            return  SFSymbol.followersIcon
        }
    }
    
    var title: String {
        switch self {
        case .repos:
            return "Public Repos"
        case .gitsts:
            return "Public Gitsts"
        case .following:
            return "Following"
        case .followers:
            return "Followers"
        }
    }
}
