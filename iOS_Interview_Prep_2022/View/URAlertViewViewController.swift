//
//  URAlertViewViewController.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/6/22.
//

import UIKit

class URAlertViewViewController: UIViewController {
    
    let alertView = UIView()
    let errorTitle = URTitleLabel(textAlignment: .center, fontSize: 20)
    let errorBody = URBodyLabel(textAlignment: .center)
    let actionButton = URButton(backgroundColor: .systemPink, titleLabel: "OK")

    private var alertTitle: String
    private var bodyTitle: String
    private var buttonTitle: String
    
    init(title: String, body: String, buttonTitle: String){
        self.alertTitle = title
        self.bodyTitle = body
        self.buttonTitle = buttonTitle
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        configureContainerView()
        configureTitleLabel()
        configureButton()
        configureBodyLabel()
        
    }
    
    func configureContainerView() {
        view.addSubview(alertView)
        alertView.backgroundColor = .systemBackground //dark mode ma black and light mode ma white
        alertView.layer.cornerRadius = 10
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.layer.borderColor = UIColor.white.cgColor
        alertView.layer.borderWidth = 2
        
        NSLayoutConstraint.activate([
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.heightAnchor.constraint(equalToConstant: 180),
            alertView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100)
        ])
    }
    
    func configureTitleLabel() {
        alertView.addSubview(errorTitle)
        errorTitle.text = alertTitle
        
        NSLayoutConstraint.activate([
            errorTitle.topAnchor.constraint(equalTo: alertView.topAnchor, constant: 20),
            errorTitle.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 10),
            errorTitle.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -10),
            errorTitle.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    func configureBodyLabel(){
        alertView.addSubview(errorBody)
        errorBody.text = bodyTitle
        
        NSLayoutConstraint.activate([
            errorBody.topAnchor.constraint(equalTo: errorTitle.bottomAnchor, constant: 20),
            errorBody.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            errorBody.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            errorBody.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -20),
        ])
    }
    
    
    func configureButton() {
        alertView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissAlertView), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: alertView.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
     }
    
    @objc func dismissAlertView(){
        
        dismiss(animated: true)
    }
    

}
