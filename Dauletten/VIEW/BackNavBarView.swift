//
//  BackNavBarView.swift
//  AidynNury
//
//  Created by Eldor Makkambayev on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BackNavBarView: UIView {
    //    MARK: - Properties
    var rightButtonImage: UIImage?
    var rightButtonTitle: String?
    var rightButtonWidth: CGFloat
    
    var goBack: (() -> ())?
    var rightButtonTarget: (() -> ())?
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "feather_arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton()
        button.setImage(rightButtonImage, for: .normal)
        button.setTitle(rightButtonTitle, for: .normal)
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .getSFProSemiboldFont(on: 16)
        button.contentMode = .scaleAspectFit
        button.titleLabel?.textAlignment = .right
        
        return button
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .mainColor
        label.font = .getMontserratMediumFont(on: 14)
        label.textAlignment = .center
        
        return label
    }()
    
    //    MARK: - Initialization
    
    init(title: String = "", rightButtonImage: UIImage? = nil, rightButtonTitle: String? = nil, rightButtonWidth: CGFloat = 25) {
        self.rightButtonWidth = rightButtonWidth
        super.init(frame: .zero)
        self.rightButtonTitle = rightButtonTitle
        self.rightButtonImage = rightButtonImage
        self.titleLabel.text = title
        setupView()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup function
    
    private func setupView() -> Void {
        backgroundColor = .backColor
        self.rightButton.isHidden = self.rightButtonImage == nil && self.rightButtonTitle == nil
        
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
        rightButton.addTarget(self, action: #selector(rightButtonAction), for: .touchUpInside)
        
        addSubview(backButton)
        backButton.snp.makeConstraints { (make) in
            make.left.equalTo(24)
            make.centerY.equalTo(snp.bottom).offset(-22)
            make.height.width.equalTo(25)
        }
        
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo((25+rightButtonWidth))
            make.right.equalTo(-(25+rightButtonWidth))
            make.centerY.equalTo(backButton)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.centerY.equalTo(snp.bottom).offset(-22)
            make.height.equalTo(25)
            make.width.equalTo(rightButtonWidth)
        }
        
    }
    
    @objc func goToBack() -> Void {
        self.goBack?()
    }
    
    @objc func rightButtonAction() -> Void {
        self.rightButtonTarget?()
    }
}
