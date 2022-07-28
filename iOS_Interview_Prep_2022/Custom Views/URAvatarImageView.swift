//
//  URAvatarImageView.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/9/22.
//

import UIKit

class URAvatarImageView: UIImageView {

    let placeholderImage = UIImage(named: "avatar-placeholder")
    
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 10
        image = placeholderImage
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func downloadImage(urlString: String) {
        
        let cacheKey = NSString(string: urlString)
        
        if let cacheImage = cache.object(forKey: cacheKey) { //retrive the image from the cache
            self.image = cacheImage
            return //return from the function...
        }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self else { return }
            
            if let _ = error { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            
            guard let image = UIImage(data: data) else { return }
            
            self.cache.setObject(image, forKey: cacheKey) //sett the image on the cache
            
            DispatchQueue.main.async {
                self.image = image
            }
            
        }
        
        task.resume()
        
    }
    
}
