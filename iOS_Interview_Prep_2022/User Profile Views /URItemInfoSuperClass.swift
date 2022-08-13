//
//  URItemInfoSuperClass.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/12/22.
//

import UIKit

class URItemInfoSuperClass: UIViewController {
    
    let stackView = UIStackView()
    let itemInfoVcOne = URItemInfoVC()
    let itemInfoVcTwo = URItemInfoVC()
    let actionButton = URButton()
    
    let user: User
    
    init(user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        configureStackView()
        layoutUI()
        
    }
    
    private func configureBackgroundView(){
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.addArrangedSubview(itemInfoVcOne)
        stackView.addArrangedSubview(itemInfoVcTwo)
    }
    
    private func layoutUI(){
        view.addSubview(stackView) //we dont need to addSubviews for itemInfoVC1 and itemInfoVC2 because its added in the stackView
        view.addSubview(actionButton)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
}
