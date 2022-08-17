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
        actionButtonPressed()
    }
    
    private func configureItems() {
        itemInfoVcOne.set(itemInfoType: .following, withCount: user.following)
        itemInfoVcTwo.set(itemInfoType: .followers, withCount: user.followers)
        actionButton.set(backgroundColor: .systemGreen, titleLable: "Get Followers")
    }
    
    private func actionButtonPressed(){
        actionButton.addTarget(self, action: #selector(buttonPressedAction), for: .touchUpInside)
    }
    
    @objc func buttonPressedAction() {
        delegate?.didSelectGetFollowers()
    }
    
}
