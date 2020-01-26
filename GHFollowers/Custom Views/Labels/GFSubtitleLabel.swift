//
//  GFSubtitleLabel.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 25/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFSubtitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    convenience init(fontSize: CGFloat) {
        self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not Implemented")
    }
    
    private func configure() {
        textColor = .secondaryLabel
        numberOfLines = 1
        textAlignment = .left
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }
    
}
