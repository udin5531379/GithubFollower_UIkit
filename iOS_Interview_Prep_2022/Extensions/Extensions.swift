//
//  Extensions.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/7/22.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    func presentURAlertViewControllerOnTheMainThread(title: String, body: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertView = URAlertViewViewController(title: title, body: body, buttonTitle: buttonTitle)
            alertView.modalPresentationStyle = .overFullScreen
            alertView.modalTransitionStyle = .crossDissolve
            self.present(alertView, animated: true)
        }
    }
    
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.alpha = 0
        
        UIView.animate(withDuration: 0.8) {
            containerView.alpha = 0.8
        }
        
        let spinningIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(spinningIndicator)
        
        spinningIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            spinningIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            spinningIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        spinningIndicator.startAnimating()
    }
    
    
    func stopLoadingView(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview()
            containerView = nil
        }
    }
    
    func showEmptyStateView(with message: String, in view: UIView){
        
        let emptyView = EmptyVC(message: message)
        emptyView.frame = view.bounds
        view.addSubview(emptyView)
        
    }
    
    func showSafariView(for user: User) {
        
        let url = URL(string: user.htmlUrl)
        
        guard let url = url else {
            presentURAlertViewControllerOnTheMainThread(title: "Error", body: "The url for this user is invalid. Please try again later", buttonTitle: "OK")
            return
        }
        
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        safariVC.modalPresentationStyle = .formSheet
        present(safariVC, animated: true)
    }
    
}
