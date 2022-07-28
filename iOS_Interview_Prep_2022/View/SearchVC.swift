//
//  SearchVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/3/22.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView = UIImageView()
    let usernameTextField = URTextField()
    let getUsernameButton = URButton(backgroundColor: .systemGreen, titleLabel: "Get Followers")
    
    
    override func viewDidLoad() { //loaded only once
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        createDismissTapGesture()
        
        configureLogoView()
        configureTextField()
        configureUsernameButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) { //loaded everytime the view appears in the screen
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing)) //end editing automatically dismisses the keyboard
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC() {
        if let username = usernameTextField.text, !username.isEmpty { // !(username.isEmpty) true bhayo bhaney matra run huncha.
            let followerListVC = FollowersListVC(username: username)
            followerListVC.title = username
            navigationController?.pushViewController(followerListVC, animated: true)
        } else {
            let alert = URAlertViewViewController(title: "Oppss", body: "Please Enter the username", buttonTitle: "OK")
            alert.modalPresentationStyle = .overFullScreen
            alert.modalTransitionStyle = .crossDissolve
            present(alert, animated: true)
            return
        }
     }
    
    
    func configureLogoView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureTextField() {
        view.addSubview(usernameTextField)
        
        usernameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            usernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 30),
            usernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            usernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func configureUsernameButton(){
        view.addSubview(getUsernameButton)
        
        getUsernameButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            getUsernameButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            getUsernameButton.heightAnchor.constraint(equalToConstant: 50),
            getUsernameButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            getUsernameButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
}
