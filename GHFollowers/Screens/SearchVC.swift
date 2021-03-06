//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Piotr Szadkowski on 03/01/2020.
//  Copyright © 2020 Piotr Szadkowski. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Views
    
    let logoIV          = UIImageView()
    let searchTF        = GFTextField()
    let searchButton    = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    var logoTopConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    
    var isUsernameEntered: Bool {
        return !searchTF.text!.isEmpty
    }
    
    // MARK: - Init
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoIV()
        configureSearchTF()
        configureSearchButton()
        addResignKeyboardTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Layout Configuration
    
    @objc private func handleKeyboard(_ notification: NSNotification) {
        guard is4Inch else { return }
        if notification.name == UIResponder.keyboardWillShowNotification {
            UIView.animate(withDuration: 0.3) { self.logoTopConstraint.constant = 0; self.view.layoutIfNeeded() }
        } else {
            UIView.animate(withDuration: 0.3) { self.logoTopConstraint.constant = 80; self.view.layoutIfNeeded() }
        }
    }
    
    private func configureLogoIV() {
        view.addSubview(logoIV)
        logoIV.translatesAutoresizingMaskIntoConstraints = false
        logoIV.image = UIImage(named: "gh-logo")!
        
        logoTopConstraint = logoIV.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80)
        
        NSLayoutConstraint.activate([
            logoTopConstraint,
            logoIV.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoIV.heightAnchor.constraint(equalToConstant: 200),
            logoIV.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureSearchTF() {
        view.addSubview(searchTF)
        searchTF.delegate = self
        
        NSLayoutConstraint.activate([
            searchTF.topAnchor.constraint(equalTo: logoIV.bottomAnchor, constant: 48),
            searchTF.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchTF.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchTF.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureSearchButton() {
        view.addSubview(searchButton)
        searchButton.addTarget(self, action: #selector(pushFollowersVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func addResignKeyboardTapGesture() {
        let tapGesutre = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tapGesutre)
    }
    
    // MARK: - Business Logic
    
    @objc func pushFollowersVC() {
        guard isUsernameEntered else {
            presentGFAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😀.", buttonTitle: "OK")
            return
        }
        let followersListVC = FollowersListVC()
        followersListVC.username = searchTF.text

        navigationController?.pushViewController(followersListVC, animated: true)
        cleanControllerState()
    }
    
    
    private func cleanControllerState() {
        view.endEditing(true)
        searchTF.text = ""
    }
}

extension SearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowersVC()
        return true
    }
    
}
