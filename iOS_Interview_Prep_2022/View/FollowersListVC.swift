//
//  FollowersListVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/6/22.
//

import UIKit

class FollowersListVC: UIViewController {
    
    private var collectionView: UICollectionView! //We are declaring it in viewDidLoad hence using the bang operator
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    private var followers: [Follower] = []
    private var username : String
    
    var page = 1
    var hasMoreFollowers = true
    
    init(username: String) {
        self.username = username
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    enum Section {
        case main
    }
    
    override func viewDidLoad() { //loaded only once
        super.viewDidLoad()
        configureFollowerListVC()
        manageNetwork(username: username, page: page)
        configureCollectionView()
        configureDataSource()
        
    }
    
    override func viewWillAppear(_ animated: Bool) { //loaded each time the view appears
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    
    func configureFollowerListVC(){
        view.backgroundColor = .systemBackground
        navigationController?.title = username
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func manageNetwork(username: String, page: Int){
        
        showLoadingView()
        
        NetworkManager.shared.getFollowers(username: username, page: page) { [weak self] result in
            
            guard let self = self else { return }
            
            self.stopLoadingView()
            
            switch result {
                
            case .success(let followers):
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                self.updateData()
                print("\(self.page), followers: \(followers.count)")
            
            case .failure(let error):
                
                self.presentURAlertViewControllerOnTheMainThread(title: "Something went wrong", body: error.rawValue, buttonTitle: "OK")
            
            }
        }
    }
    
    
    
    
    func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self //delegate is something that is waiting back for an action
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseId)
        
        
    }
    
    
    
    
    func configureDataSource(){
        
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView) { collectionView, indexPath, follower in
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseId, for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        }

    }
    
    func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers) //yesma data populate bhai sakcha.
        dataSource.apply(snapshot, animatingDifferences: true)
    }

}

extension FollowersListVC: UICollectionViewDelegate {
    
    //dragging end huney bittikai trigger huney function...
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        let offsetY = scrollView.contentOffset.y //kati samma scroll garna sakincha for the scroll View in y diredction ko height
        let contentHeight = scrollView.contentSize.height //total content ko height
        let heightOfScreen = scrollView.frame.size.height
        
        if offsetY > contentHeight - heightOfScreen {
            guard hasMoreFollowers else { return }
            self.page += 1
            manageNetwork(username: username, page: page)
        }
        
    }
}