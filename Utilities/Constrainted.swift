//
//  Constrainted.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 27/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

@propertyWrapper struct Constrainted<View: UIView> {
    
    var wrappedValue: View {
        didSet {
            wrappedValue.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    init(wrappedValue: View) {
        self.wrappedValue = wrappedValue
        wrappedValue.translatesAutoresizingMaskIntoConstraints = false
    }
}
