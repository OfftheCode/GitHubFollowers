//
//  UIViewController+Extension.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 04/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentGFAlertOnMainThread(title: String, message: String, buttonTitle: String, style: GFAlertVC.Style = .error) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(title: title, message: message, buttonTitle: buttonTitle, style: style)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showSafariVC(for url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func showLoadingView() {
        
        containerView = UIView(frame: view.bounds)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0.0
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
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
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = EmptyStateView(with: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
