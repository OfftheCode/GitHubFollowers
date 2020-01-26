//
//  TAMIC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 27/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

@propertyWrapper struct TAMIC<Value: UIView> {
    
    var wrappedValue: Value { return wrappedView }
    
    var wrappedView: Value {
        didSet {
            wrappedView.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    init(_ wrappedView: Value) {
        wrappedView.translatesAutoresizingMaskIntoConstraints = false
        self.wrappedView = wrappedView
    }
}
