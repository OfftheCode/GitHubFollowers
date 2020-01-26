//
//  UIView+Extension.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 25/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { $0.translatesAutoresizingMaskIntoConstraints = false; addSubview($0) }
    }
    
}
