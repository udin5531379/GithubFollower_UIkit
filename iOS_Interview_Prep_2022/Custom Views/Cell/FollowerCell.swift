//
//  FollowerCell.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/9/22.
//

import Foundation
import UIKit

class FollowerCell: UICollectionViewCell {
    
    static let reuseId = "FollowerCell"
    
    let avatarImage = URAvatarImageView(frame: .zero)
    let userLabel = URTitleLabel(textAlignment: .center, fontSize: 16)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower){
        userLabel.text = follower.login
        avatarImage.downloadImage(urlString: follower.avatarUrl)
    }
    
    private func configure() {
        contentView.addSubview(avatarImage)
        contentView.addSubview(userLabel)
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            userLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 8),
            userLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            userLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            userLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
