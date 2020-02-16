//
//  Loadable.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 16/02/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

protocol Loadable: class {
    var containerView: UIView! { get set }
    func showLoadingView()
    func hideLoadingView()
    func showEmptyStateView(with message: String, in view: UIView)
    func removeEmptyStateView()
}

extension Loadable where Self: UIViewController {
    
    func showLoadingView() {
        
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.0
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func hideLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(with: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func removeEmptyStateView() {
        let emptyStateView = view.subviews.first { (view) -> Bool in
            view is EmptyStateView
        }
        
        emptyStateView?.removeFromSuperview()
    }
    
}
