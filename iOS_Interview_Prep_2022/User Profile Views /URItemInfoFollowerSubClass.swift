//
//  URItemInfoFollowerSubClass.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 8/12/22.
//

import UIKit

class URItemInfoFollowerSubClass: URItemInfoSuperClass {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoVcOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoVcTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, titleLable: "Get Followers")
    }
    
}
