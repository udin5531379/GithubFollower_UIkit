//
//  UIHelperFiles.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/17/22.
//

import UIKit

struct UIHelper {
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let viewWidth = view.bounds.width
        let padding: CGFloat = 12
        let paddingBetweenCells : CGFloat = 10
        let availableWidth = viewWidth - (padding * 2) - (paddingBetweenCells * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return flowLayout
    }
}
