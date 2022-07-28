//
//  URTextField.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/5/22.
//

import UIKit

class URTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2, compatibleWith: .current)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        autocorrectionType = .no
        
        returnKeyType = .search
        
        placeholder = "Enter a username"
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}
