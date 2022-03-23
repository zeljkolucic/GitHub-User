//
//  AvatarImageView.swift
//  GitHub-User
//
//  Created by Zeljko Lucic on 23.3.22..
//

import UIKit

class AvatarImageView: UIImageView {
    
    // MARK: - Properties
    
    private let placeholderImage: UIImage = {
        let image = UIImage.avatarPlaceholder
        return image!
    }()
    
    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true // image inside imageView is clipped to imageView's corners
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }

}
