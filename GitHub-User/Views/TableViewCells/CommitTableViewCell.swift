//
//  CommitTableViewCell.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 24.3.22..
//

import UIKit

class CommitTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "CommitTableViewCell"
    
    // MARK: - Properties
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let messageLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .left, fontSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    let avatarImageView: AvatarImageView = {
        let imageView = AvatarImageView(frame: .zero)
        return imageView
    }()
    
    let authorLabel: SecondaryTitleLabel = {
        let label = SecondaryTitleLabel(fontSize: 16)
        return label
    }()
    
    // MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    
    private func configure() {
        containerView.backgroundColor = .secondarySystemBackground
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(avatarImageView)
        containerView.addSubview(authorLabel)
    }
    
    private func setConstraints() {
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 10).isActive = true
        messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        messageLabel.trailingAnchor.constraint(lessThanOrEqualTo: containerView.trailingAnchor, constant: -10).isActive = true
        
        avatarImageView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        avatarImageView.widthAnchor.constraint(equalToConstant: 25).isActive = true
        avatarImageView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20).isActive = true
        avatarImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        avatarImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        authorLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor).isActive = true
        authorLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 5).isActive = true
        authorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }
    
}
