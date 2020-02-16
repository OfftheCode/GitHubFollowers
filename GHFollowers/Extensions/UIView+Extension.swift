//
//  UIView+Extension.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 25/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

extension UIView {
    
    func pinToEdges(of superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor)
        ])
    }
    
    func addSubviews(_ views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false; addSubview($0) }
    }
    
}
