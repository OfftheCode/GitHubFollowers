//
//  Constraints.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 27/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

extension UIView {
    func stretch(padding: CGFloat = 0, to view: UIView?) {
        guard let parentView = view ?? superview else { return }
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: padding),
            trailingAnchor.constraint(equalTo: parentView.trailingAnchor, constant: -padding)
        ])
    }
    
    func addAndStretch(with padding: CGFloat = 0, _ views: UIView...) {
        views.forEach { addSubview($0); $0.stretch(padding: padding, to: self)}
    }
}
