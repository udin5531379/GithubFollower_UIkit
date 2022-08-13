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
    }
    
    private func configureItems() {
        itemInfoVcOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoVcTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, titleLable: "Github Profile")
    }
}
