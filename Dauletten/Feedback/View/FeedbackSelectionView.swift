//
//  FeedbackSelectionView.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 2/14/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class FeedbackSelectionView: UIView {

//    MARK: - Properties
    var buttonTarget: (() -> ())?
    lazy var selectorImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        
        return image
    }()
    
    lazy var selectorButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .getSFProSemiboldFont(on: 17)
        button.contentHorizontalAlignment = .left
    
        return button
    }()
    
//    MARK: - Initialization
    init(image: UIImage, title: String) {
        super.init(frame: .zero)
        self.selectorButton.setTitle(title, for: .normal)
        self.selectorImage.image = image
        setupView()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() -> Void {
        addSubview(selectorImage)
        selectorImage.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(24)
            make.height.width.equalTo(35)
        }
        
        addSubview(selectorButton)
        selectorButton.snp.makeConstraints { (make) in
            make.left.equalTo(selectorImage.snp.right).offset(30)
            make.right.equalTo(-16)
            make.centerY.equalTo(selectorImage)
        }
    }
    
    private func setupAction() -> Void {
        self.selectorButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @objc func buttonAction() -> Void {
        buttonTarget?()
    }
}
