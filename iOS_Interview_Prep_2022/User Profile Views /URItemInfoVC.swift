//
//  URSecondHeaderVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/9/22.
//

import UIKit

enum ItemInfoType {
    case repos, gists, followers, following
}

class URItemInfoVC: UIView {
    
    let symbolImageView = UIImageView()
    let titleLabel = URTitleLabel(textAlignment: .left, fontSize: 14)
    let countLabel = URTitleLabel(textAlignment: .center, fontSize: 14)
    
    var viewsArray : [UIView] = []
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(){
        viewsArray = [symbolImageView, titleLabel, countLabel]
        
        for viewArray in viewsArray {
            addSubview(viewArray)
            viewArray.translatesAutoresizingMaskIntoConstraints = false
        }
        
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
    }
    
    
    func layoutUI() {
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 15),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            symbolImageView.heightAnchor.constraint(equalToConstant: 30),
            symbolImageView.widthAnchor.constraint(equalToConstant: 30),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            countLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 16)
            
        ])
        
    }
    
    func set(itemInfoType: ItemInfoType, withCount count: Int){
        
        switch itemInfoType {
            
        case .repos:
            symbolImageView.image = UIImage(systemName: SFSymbols.repos)
            titleLabel.text = "Repos"
            
        case .gists:
            symbolImageView.image = UIImage(systemName: SFSymbols.gists)
            titleLabel.text = "Gists"
            
        case .followers:
            symbolImageView.image = UIImage(systemName: SFSymbols.followers)
            titleLabel.text = "Followers"
            
        case .following:
            symbolImageView.image = UIImage(systemName: SFSymbols.following)
            titleLabel.text = "Following"
        }
        
        countLabel.text = String(count)
        
    }
    
}
