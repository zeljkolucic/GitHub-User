//
//  UserDetailsViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit
import SafariServices

class UserDetailsViewController: DataLoadingViewController {
    
    // MARK: - Properties
    
    private let headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let followersView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let dateLabel: BodyLabel = {
        let label = BodyLabel(textAlignment: .center)
        return label
    }()
    
    private var username: String
    private var user: User?
    
    // MARK: - Initialization
    
    init(username: String) {
        self.username = username
        
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
        
        getUser()
    }
    
    // MARK: Layout
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
    }
    
    private func addSubviews() {
        view.addSubview(headerView)
        view.addSubview(repoView)
        view.addSubview(followersView)
        view.addSubview(dateLabel)
    }
    
    private func setConstraints() {
        headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        headerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        headerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        repoView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20).isActive = true
        repoView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        repoView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        repoView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        followersView.topAnchor.constraint(equalTo: repoView.bottomAnchor, constant: 20).isActive = true
        followersView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        followersView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        followersView.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: followersView.bottomAnchor, constant: 20).isActive = true
        dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func addChildViewController(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.frame = containerView.bounds
        child.didMove(toParent: self)
    }
    
    // MARK: Network
    
    private func getUser() {
        presentLoadingView()
        NetworkManager.shared.getUserDetails(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.user = user
                    
                    let userInfoHeaderViewController = UserInfoHeaderViewController(user: user)
                    self.addChildViewController(child: userInfoHeaderViewController, to: self.headerView)
                    
                    let repoItemInfoViewController = RepoItemInfoViewController(user: user)
                    repoItemInfoViewController.delegate = self
                    self.addChildViewController(child: repoItemInfoViewController, to: self.repoView)
                    
                    let followersItemInfoViewController = FollowersItemInfoViewController(user: user)
                    followersItemInfoViewController.delegate = self
                    self.addChildViewController(child: followersItemInfoViewController, to: self.followersView)
                    
                    let date = user.createdAt.convertToMonthYearFormat()
                    self.dateLabel.text = "On GitHub since \(date)"
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: .error, message: error.rawValue, buttonTitle: .ok, delegate: self)
            }
        }
    }
    
}

// MARK: - Repositories Delegate

extension UserDetailsViewController: RepositoriesDelegate {
    
    func didTapRepositoriesButton() {
        guard let user = user else { return }
        let repositoriesViewController = RepositoriesViewController(user: user)
        navigationController?.pushViewController(repositoriesViewController, animated: true)
    }
    
}

// MARK: - Followers Delegate
    
extension UserDetailsViewController: FollowersDelegate {
    
    func didTapGitHubProfile() {
        guard let user = user, let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: .invalidUrl, message: .invalidUrlMessage, buttonTitle: .ok)
            return
        }
        
        let safariViewController = SFSafariViewController(url: url)
        safariViewController.preferredControlTintColor = .systemGreen
        present(safariViewController, animated: true)
    }
    
}

extension UserDetailsViewController: AlertDelegate {
    
    func dismiss() {
        navigationController?.popViewController(animated: true)
    }
    
}
