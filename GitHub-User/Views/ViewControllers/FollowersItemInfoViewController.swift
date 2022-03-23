//
//  FollowerItemInfoViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

protocol FollowersDelegate: AnyObject {
    func didTapGitHubProfile()
}

class FollowersItemInfoViewController: ItemInfoViewController {
    
    // MARK: - Properties
    
    weak var delegate: FollowersDelegate?
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        itemInfoViewLeft.configure(with: .followers, count: user.followers)
        itemInfoViewRight.configure(with: .following, count: user.following)
        button.configure(with: .systemGreen, title: "GitHub Profile")
    }
    
    // MARK: - Actions
    
    override func didTapButton() {
        delegate?.didTapGitHubProfile()
    }
    
}
