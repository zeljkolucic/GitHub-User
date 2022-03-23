//
//  RepositoryDetailsViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class RepositoryDetailsViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Properties
    
    private let username: String
    private let repository: String
    
    // MARK: - Initialization
    
    init(username: String, repository: String) {
        self.username = username
        self.repository = repository
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Controller Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        addSubviews()
        setConstraints()
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBlue
    }
    
    private func addSubviews() {
        
    }
    
    private func setConstraints() {
        
    }
    
    // MARK: - Network
    
}
