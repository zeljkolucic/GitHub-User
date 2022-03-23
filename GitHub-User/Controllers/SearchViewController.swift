//
//  SearchViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class SearchViewController: UIViewController {

    // MARK: - Properties
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: .githubLogo)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let usernameTextField: TextField = {
        let textField = TextField()
        textField.placeholder = "Enter a username"
        return textField
    }()
    
    private let searchButton: Button = {
        let button = Button(backgroundColor: .systemGreen, title: "Get Followers")
        return button
    }()
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addSubviews()
        setConstraints()
        
        configureTextField()
    }
    
    // MARK: - Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(usernameTextField)
        view.addSubview(searchButton)
    }
    
    private func setConstraints() {
        logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48).isActive = true
        usernameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        usernameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        usernameTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        searchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 50).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50).isActive = true
        searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -50).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Configuration
    
    private func configureTextField() {
        usernameTextField.delegate = self
    }

}

// MARK: - Text Field Delegate

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
    
}
