//
//  GFInfoItemVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 02/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class GFInfoItemVC: UIViewController {
    
    // MARK: - Properties
    
    let user: User
    
    private enum Layout {
        static let padding: CGFloat = 20
        static let smallPadding: CGFloat = 8
        static let mediumPadding: CGFloat = 16
        static let cornerRadius: CGFloat = 18
    }
    
    // MARK: - Views
    
    @Constrainted var infoStackView = UIStackView()
    let leftInfoView = GFItemInfoView()
    let rightInfoView = GFItemInfoView()
    @Constrainted var actionButton = GFButton()
    
    // MARK: - Init
    
    init(with user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        layoutUI()
        configureButton()
    }
    
    private func configureButton() {
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() { }
    
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
            infoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: Layout.smallPadding),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.mediumPadding),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.mediumPadding),
            infoStackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
            
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -Layout.padding),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Layout.padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Layout.padding)
        ])
    }
    
}
