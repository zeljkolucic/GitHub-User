//
//  RepositoriesViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class RepositoriesViewController: DataLoadingViewController {
    
    // MARK: - Properties
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var repositories = [Repository]()
    
    private let user: User
    
    // MARK: - Initialization
    
    init(user: User) {
        self.user = user
        
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
        fetchRepositories()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
        navigationItem.title = .repositories
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
    
    private func fetchRepositories() {
        presentLoadingView()
        NetworkManager.shared.fetchRepositories(for: user.login) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let repositories):
                self.repositories = repositories
                
                if self.repositories.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: .noRepos, view: self.view)
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

// MARK: - Table View Delegate and Data Source

extension RepositoriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier) as? RepositoryTableViewCell else {
            return UITableViewCell()
        }
        
        let repository = repositories[indexPath.row]
        cell.titleLabel.text = repository.name
        cell.languageLabel.text = repository.language
        
        let updatedAt = repository.updatedAt.convertToMonthYearFormat()
        cell.updatedAtLabel.text = "Updated at \(updatedAt)"
        
        cell.openIssuesLabel.text = "Open issues: \(repository.openIssues)"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let repository = repositories[indexPath.row].name
        let repositoryDetailsViewController = RepositoryDetailsViewController(user: user, repository: repository)
        navigationController?.pushViewController(repositoryDetailsViewController, animated: true)
    }
    
}

// MARK: - Alert Delegate

extension RepositoriesViewController: AlertDelegate {
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
}
