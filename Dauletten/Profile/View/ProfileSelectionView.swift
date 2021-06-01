//
//  ProfileSelectionView.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class ProfileSelectionView: UIView {

//    MARK: - Properties
    
    lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit

        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserratMediumFont(on: 14)
        label.textColor = .white
        
        return label
    }()
    
    lazy var selectionIcon: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "feather_chevron-right")
        image.contentMode = .scaleAspectFit
        
        return image
    }()

// MARK: - Initialization
    init(icon: UIImage, title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
        self.icon.image = icon
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup function
    private func setupView() -> Void {
        self.layer.cornerRadius = 20
        self.layer.masksToBounds = true
        self.backgroundColor = .upperColor
        
        addSubview(icon)
        icon.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.left.equalTo(12)
            make.height.width.equalTo(32)
        }
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.left.equalTo(icon)
            make.right.equalTo(-20)
            make.bottom.equalTo(-10)
        }
        addSubview(selectionIcon)
        selectionIcon.snp.makeConstraints { (make) in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(-12)
        }

    }

}
