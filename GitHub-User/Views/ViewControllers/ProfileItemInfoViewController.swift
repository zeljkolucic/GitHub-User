//
//  ProfileItemInfoViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

protocol ProfileDelegate: AnyObject {
    
    func didTapGithubProfileButton()
    
}

class ProfileItemInfoViewController: ItemInfoViewController {
    
    // MARK: - Properties
    
    weak var delegate: ProfileDelegate?
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        itemInfoViewLeft.configure(with: .repos, count: 0)
        itemInfoViewRight.configure(with: .gists, count: 0)
        button.configure(with: .systemPurple, title: "Github Profile")
    }
    
    // MARK: - Actions
    
    override func didTapButton() {
        delegate?.didTapGithubProfileButton()
    }
    
}
