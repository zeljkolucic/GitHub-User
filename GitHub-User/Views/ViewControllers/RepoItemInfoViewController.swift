//
//  RepoItemInfoViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

protocol RepositoriesDelegate: AnyObject {
    func didTapRepositoriesButton()
}

class RepoItemInfoViewController: ItemInfoViewController {
    
    // MARK: - Properties
    
    weak var delegate: RepositoriesDelegate?
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
    }
    
    // MARK: - Configuration
    
    private func configure() {
        itemInfoViewLeft.configure(with: .repos, count: user.publicRepos)
        itemInfoViewRight.configure(with: .gists, count: user.publicGists)
        button.configure(with: .systemPink, title: "Repositories")
    }
    
    // MARK: - Actions
    
    override func didTapButton() {
        delegate?.didTapRepositoriesButton()
    }
    
}
