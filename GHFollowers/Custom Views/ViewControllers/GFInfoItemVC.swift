//
//  GFInfoItemVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 02/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFInfoItemVC: UIViewController {
    
    private enum Layout {
        static let padding: CGFloat = 20
        static let cornerRadius: CGFloat = 18
    }
    
    // MARK: - Properties
    
    @Constrainted var infoStackView = UIStackView()
    let leftInfoView = GFItemInfoView()
    let rightInfoView = GFItemInfoView()
    @Constrainted var actionButton = GFButton()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        layoutUI()
    }
    
    private func configureBackgroundView() {
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = Layout.cornerRadius
    }
    
    private func configureStackView() {
        infoStackView.axis = .horizontal
        infoStackView.distribution = .equalSpacing
        
        infoStackView.addArrangedSubview(leftInfoView)
        infoStackView.addArrangedSubview(rightInfoView)
    }
    
    private func layoutUI() {
        view.addSubviews(infoStackView, actionButton)
        
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.padding),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding),
            infoStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.65),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Layout.padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding)
        ])
    }
    
}
