//
//  FollowersListVC.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/6/22.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func getUsernameFromUserInfoVC(username: String)
}

class FollowersListVC: UIViewController {
    
    private var collectionView: UICollectionView! //We are declaring it in viewDidLoad hence using the bang operator
    private var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    
    private var followers: [Follower] = []
    private var username : String
    private var filteredFollowers : [Follower] = []
    
    var page = 1
    var hasMoreFollowers = true
    var isSearchBarActive = false
    
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
        configureSearchController()
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
        let doneButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(leftBarButtonItemTapped))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc func leftBarButtonItemTapped(){
        print("Plus clicked")
        
        NetworkManager.shared.getUser(username: username) { [weak self] results in
            guard let self = self else { return }
            
            switch results {
            case .success(let user):
                
                let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
                print(favorite)
                
                PersistanceManager.updateWith(favorite: favorite, actionType: .add) { error in
                    print(favorite)
                    guard let error = error else {
                        self.presentURAlertViewControllerOnTheMainThread(title: "User added to favorites", body: "Success!!", buttonTitle: "OK")
                        return
                    }
                    
                    self.presentURAlertViewControllerOnTheMainThread(title: "Something went wrong", body: "\(error.rawValue)", buttonTitle: "OK")
                    
                 }
            case .failure(let error):
                self.presentURAlertViewControllerOnTheMainThread(title: "Sorry could not figure out which user you are trying to favorite!", body: "Launch the app again \(error)", buttonTitle: "OK")
            }
        }
        
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
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
                
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: "\(username) does not have any followers! Follow them :)", in: self.view)
                    }
                    return
                }
                
                self.updateData(followers: self.followers)
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
    
    func updateData(followers: [Follower]) {
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearchBarActive ? filteredFollowers : followers
        let itemTapFollower = activeArray[indexPath.item]
        
        print(itemTapFollower)
        let destinationVC = UserInfoVC(username: itemTapFollower.login)
        destinationVC.delegate = self
        let navigationVC = UINavigationController(rootViewController: destinationVC)
        present(navigationVC, animated: true)
    }
    
}

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) { //this function is going to trigger after each word that we type in the searchfield
        
        guard let filtered = searchController.searchBar.text, !filtered.isEmpty else { return }
        
        isSearchBarActive = true
        
        filteredFollowers = followers.filter { $0.login.lowercased().contains(filtered.lowercased()) }
        updateData(followers: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearchBarActive = false
        
        updateData(followers: self.followers)
    }
    
    
}

extension FollowersListVC: FollowerListVCDelegate {
    
    func getUsernameFromUserInfoVC(username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        manageNetwork(username: username, page: page)
    }
    
}
