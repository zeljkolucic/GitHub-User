//
//  FollowerItemInfoViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

protocol FollowersDelegate: AnyObject {
    
    func didTapGetFollowersButton()
    
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
        itemInfoViewLeft.configure(with: .followers, count: 0)
        itemInfoViewRight.configure(with: .following, count: 0)
        button.configure(with: .systemGreen, title: "Get Followers")
    }
    
    // MARK: - Actions
    
    override func didTapButton() {
        delegate?.didTapGetFollowersButton()
    }
    
}
