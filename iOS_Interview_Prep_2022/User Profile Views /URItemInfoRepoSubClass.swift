//
//  URItemInfoVCSubClass.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/12/22.
//

import Foundation

class URItemInfoRepoSubClass: URItemInfoSuperClass {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
        actionButtonPressed()
    }
    
    private func configureItems() {
        itemInfoVcOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoVcTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, titleLable: "Github Profile")
    }
    
    private func actionButtonPressed(){
        actionButton.addTarget(self, action: #selector(buttonPressedAction), for: .touchUpInside)
    }
    
    @objc func buttonPressedAction(){
        delegate?.didSelectGithubProfile(for: user)
    }
    
}
