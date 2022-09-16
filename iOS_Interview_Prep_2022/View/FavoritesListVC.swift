//
//  FavoritesListVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/3/22.
//

import UIKit

class FavoritesListVC: UIViewController {
    
    let tableView = UITableView()
    var favoritesArray : [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemTeal
        retriveFavorite()
        configure()
        
    }
    
    func retriveFavorite() {
        PersistanceManager.retriveFavoritesFromUserDefaults { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                
                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No favorites yet!", in: self.view)
                } else {
                    self.favoritesArray = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                 }
            
            case .failure(let error):
                break
            }
        }
    }
    
    func configure() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.register(FavoritesCell.self, forCellReuseIdentifier: FavoritesCell.reuseID)
    }
    
}

extension FavoritesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesCell.reuseID, for: indexPath) as! FavoritesCell
        let favorite = favoritesArray[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
}
