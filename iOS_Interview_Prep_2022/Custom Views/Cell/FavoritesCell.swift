//
//  FavoritesCell.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 9/12/22.
//

import UIKit

class FavoritesCell: UITableViewCell {
    
    static let reuseID = "favoriteCell"
    var avatarImage = URAvatarImageView(frame: .zero)
    var usernameLabel = URTitleLabel(textAlignment: .left, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: Follower){
        usernameLabel.text = favorite.login
        avatarImage.downloadImage(urlString: favorite.avatarUrl)
    }
    
    private func configure() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        
        accessoryType = .disclosureIndicator
        
        let padding: CGFloat = 12
        NSLayoutConstraint.activate([
            avatarImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImage.widthAnchor.constraint(equalToConstant: 60),
            avatarImage.heightAnchor.constraint(equalToConstant: 60),
            
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 30),
            usernameLabel.widthAnchor.constraint(equalToConstant: 150)
        ])
    }

}
