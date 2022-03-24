//
//  RepositoryDetailsViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class RepositoryDetailsViewController: DataLoadingViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CommitTableViewCell.self, forCellReuseIdentifier: CommitTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let user: User
    private let repository: String
    
    private var commits = [Commit]()
    
    // MARK: - Initialization
    
    init(user: User, repository: String) {
        self.user = user
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
        configureNavigationBar()
        addSubviews()
        setConstraints()
        
        configureTableView()
        fetchCommits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavigationBar() {
        navigationItem.title = repository
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setConstraints() {
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
    }
    
    // MARK: - Configuration
    
    private func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Network
    
    func fetchCommits() {
        presentLoadingView()
        NetworkManager.shared.fetchCommits(for: user.login, for: repository) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let commits):
                self.commits = commits
                
                if self.commits.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: .noCommits, view: self.view)
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: .somethingWentWrong, message: error.rawValue, buttonTitle: .ok, delegate: self)
            }
        }
    }
    
}

extension RepositoryDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommitTableViewCell.reuseIdentifier) as? CommitTableViewCell else {
            return UITableViewCell()
        }
        
        let commit = commits[indexPath.row]
        
        cell.messageLabel.text = commit.commit.message
        
        let username = commit.commit.author.name
        let date = commit.commit.author.date
        let calendar = Calendar(identifier: .gregorian)
        let daysSinceNow = calendar.daysSinceNow(date: date)
        cell.authorLabel.text = "\(username) commited \(daysSinceNow) days ago"
        
        /// This has to fetch user first, because the owner of the repo does not have to be the same as the author of the commit
        NetworkManager.shared.getUserDetails(for: username) { result in
            switch result {
            case .success(let author):
                NetworkManager.shared.downloadImage(from: author.avatarUrl) { image in
                    DispatchQueue.main.async {
                        cell.avatarImageView.image = image
                    }
                }
            case .failure(_):
                break
            }
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
}

// MARK: - Alert Delegate

extension RepositoryDetailsViewController: AlertDelegate {
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
}
