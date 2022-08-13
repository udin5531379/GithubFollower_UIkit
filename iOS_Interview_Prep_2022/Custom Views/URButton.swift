//
//  URButton.swift
//  iOS_Interview_Prep_2022
//
//  Created by Udin Rajkarnikar on 7/4/22.
//

import UIKit

class URButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        //custom code
        configure() // this fumction contains all the frame related stuffs
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, titleLabel: String){ //backgroundColor and title are the only things that can change while resuing the button.
        super.init(frame: .zero)                        // Rest like cornerRadius, textColor, font is the same. That is why we called configure method.
        self.backgroundColor = backgroundColor
        self.setTitle(titleLabel, for: .normal)
        configure()
    }
    
    private func configure() {
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline, compatibleWith: .current)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, titleLable: String){
        self.backgroundColor = backgroundColor
        self.setTitle(titleLable, for: .normal)
    }
}
