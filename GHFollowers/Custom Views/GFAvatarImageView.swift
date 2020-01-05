//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 05/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    private let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
