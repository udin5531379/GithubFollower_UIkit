//
//  FavoritesListVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/3/22.
//

import UIKit

class FavoritesListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        
        PersistanceManager.retriveFavoritesFromUserDefaults { result in
            switch result {
            case .success(let favourites):
                print(favourites)
            case .failure(let error):
                break
            }
        }
        
    }
    
}
