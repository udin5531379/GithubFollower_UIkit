//
//  UserInfoVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/30/22.
//

import UIKit

class UserInfoVC: UIViewController {
    
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

        view.backgroundColor = .systemMint
        
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = barButtonItem
        
        print(username)
        NetworkManager.shared.getUser(username: username) { result in
            switch result {
            case .success(let user):
                print(user)
                
            case .failure(let error):
                self.presentURAlertViewControllerOnTheMainThread(title: "Something is wrong", body: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    

}
