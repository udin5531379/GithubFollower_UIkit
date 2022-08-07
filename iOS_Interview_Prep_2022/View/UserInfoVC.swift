//
//  UserInfoVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/30/22.
//

import UIKit

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    var username: String
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsSettings()
        layoutHeaderView()
        manageNetwork(username: username)
        
     }
    
    
    func viewsSettings() {
        view.backgroundColor = .systemBackground
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    
    func manageNetwork(username: String) {
        
        NetworkManager.shared.getUser(username: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: URUserInfoHeaderVC(user: user), to: self.headerView)
                }
            case .failure(let error):
                self.presentURAlertViewControllerOnTheMainThread(title: "Something is wrong", body: error.rawValue, buttonTitle: "OK")
            }
        }
        
    }
    
    func layoutHeaderView() {
        
        view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}
