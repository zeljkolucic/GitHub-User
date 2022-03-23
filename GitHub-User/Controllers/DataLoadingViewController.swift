//
//  DataLoadingViewController.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class DataLoadingViewController: UIViewController {
    
    // MARK: - Properties
    
    private var containerView: UIView?
    
    // MARK: - Methods
    
    func presentLoadingView() {
        containerView = UIView(frame: view.bounds)
        guard let containerView = containerView else { return }

        view.addSubview(containerView)
        
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView?.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, view: UIView) {
        let emptyStateView = EmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
