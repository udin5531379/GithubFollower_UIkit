//
//  URUserInfoHeaderVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/4/22.
//

import UIKit

class URUserInfoHeaderVC: UIViewController {
    
    let avatarImageView = URAvatarImageView(frame: .zero)
    let usernameLabel = URTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = SecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = SecondaryTitleLabel(fontSize: 18)
    let bioLabel = URBodyLabel(textAlignment: .left)
    
    var user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUIElements()
        addSubviews()
        layoutUI()
    }
    
    func configUIElements(){
        
        avatarImageView.downloadImage(urlString: user.avatarUrl)
        usernameLabel.text = user.login
        nameLabel.text = user.name
        
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
        
        locationLabel.text = user.location
        bioLabel.text = user.bio
        bioLabel.numberOfLines = 3
    }
    
    func addSubviews(){
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI(){
        
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 15),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            avatarImageView.heightAnchor.constraint(equalToConstant: 110),
            avatarImageView.widthAnchor.constraint(equalToConstant: 110),
            
            usernameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            nameLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: usernameLabel.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            
            locationLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 7),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 25),
            bioLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
    }
    
    

}
