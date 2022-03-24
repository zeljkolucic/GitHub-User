//
//  RepositoryTableViewCell.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit
import CoreGraphics

class RepositoryTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "RepositoryTableViewCell"
    
    // MARK: - Properties
    
    let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: TitleLabel = {
        let label = TitleLabel(textAlignment: .left, fontSize: 20)
        return label
    }()
    
    private let languageImageView: UIImageView = {
        let imageView = UIImageView(image: .circle)
        let colors: [UIColor] = [.systemGreen, .systemBlue, .systemPink, .systemOrange]
        imageView.tintColor = colors.randomElement()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let languageLabel: SecondaryTitleLabel = {
        let label = SecondaryTitleLabel(fontSize: 16)
        return label
    }()
    
    let updatedAtLabel: BodyLabel = {
        let label = BodyLabel(textAlignment: .left)
        return label
    }()
    
    let openIssuesLabel: BodyLabel = {
        let label = BodyLabel(textAlignment: .center)
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
    
    // MARK: Layout
    
    private func configure() {
        containerView.backgroundColor = .secondarySystemBackground
    }
    
    private func addSubviews() {
        contentView.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(updatedAtLabel)
        containerView.addSubview(languageImageView)
        containerView.addSubview(languageLabel)
        containerView.addSubview(openIssuesLabel)
    }
    
    private func setConstraints() {
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20).isActive = true
        
        titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 5).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10).isActive = true
        
        updatedAtLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        updatedAtLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        
        languageImageView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        languageImageView.widthAnchor.constraint(equalToConstant: 15).isActive = true
        languageImageView.topAnchor.constraint(equalTo: updatedAtLabel.bottomAnchor, constant: 20).isActive = true
        languageImageView.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor).isActive = true
        languageImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -10).isActive = true
        
        languageLabel.centerYAnchor.constraint(equalTo: languageImageView.centerYAnchor).isActive = true
        languageLabel.leadingAnchor.constraint(equalTo: languageImageView.trailingAnchor, constant: 5).isActive = true
        
        openIssuesLabel.centerYAnchor.constraint(equalTo: languageLabel.centerYAnchor).isActive = true
        openIssuesLabel.leadingAnchor.constraint(greaterThanOrEqualTo: containerView.centerXAnchor).isActive = true
        openIssuesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -10).isActive = true
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if highlighted {
            containerView.backgroundColor = .systemGray4
        } else {
            containerView.backgroundColor = .secondarySystemBackground
        }
    }
    
}
