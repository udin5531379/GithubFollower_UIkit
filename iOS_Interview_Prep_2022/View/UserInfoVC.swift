//
//  UserInfoVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/30/22.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    
    func didSelectGithubProfile(for user: User)
    func didSelectGetFollowers(for user: User)
    
}

class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = URBodyLabel(textAlignment: .center)
    
    var itemViews : [UIView] = []
    
    weak var delegate: FollowerListVCDelegate?
    
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
                    self.childVCConfiguration(user: user)
                }
            case .failure(let error):
                self.presentURAlertViewControllerOnTheMainThread(title: "Something is wrong", body: error.rawValue, buttonTitle: "OK")
            }
        }
        
    }
    
    func childVCConfiguration(user: User){
        self.add(childVC: URUserInfoHeaderVC(user: user), to: self.headerView)
        
        let infoRepo = URItemInfoRepoSubClass(user: user)
        infoRepo.delegate = self
        self.add(childVC: infoRepo, to: self.itemViewOne)
        
        let infoFollower = URItemInfoFollowerSubClass(user: user)
        infoFollower.delegate = self
        self.add(childVC: infoFollower, to: self.itemViewTwo)
        
        self.dateLabel.text = "Github since \(user.createdAt.strToDateAndDatetoStr())"
    }
    
    func layoutHeaderView() {
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 230),
            
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 10),
            itemViewOne.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: 10),
            itemViewTwo.heightAnchor.constraint(equalToConstant: 180),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: 15),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15),
            dateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }

}

extension UserInfoVC: UserInfoVCDelegate {
    
    func didSelectGithubProfile(for user: User) {
        showSafariView(for: user)
    }
    
    
    func didSelectGetFollowers(for user: User) {
        
        guard user.followers != 0 else {
            presentURAlertViewControllerOnTheMainThread(title: "No Followers", body: "Sorry this user has no followers", buttonTitle: "OK")
            return
        }
        
        self.dismiss(animated: true)
        delegate?.getUsernameFromUserInfoVC(username: user.login)
    }
    
    
}
