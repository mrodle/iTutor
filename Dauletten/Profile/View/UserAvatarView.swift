//
//  UserAvatarView.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 1/29/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class UserAvatarView: UIView {

    //MARK: - Properties
    
    var cornerView: UIView = {
        let view = UIView()
        view.backgroundColor = .upperColor
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        
        return view
    }()
        
    lazy var letterLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProSemiboldFont(on: 20)
        label.textColor = .white
        
        return label
    }()

    //    MARK: - Initialization
    
        override init(frame: CGRect) {
            super.init(frame: .zero)
            setupView()
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    //    MARK: - Setup function
        
        private func setupView() -> Void {
            self.backgroundColor = .mainColor
            self.layer.cornerRadius = 32
            self.layer.masksToBounds = true
            
            self.addSubview(cornerView)
            cornerView.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
                make.height.width.equalTo(60)
            }

            cornerView.addSubview(letterLabel)
            letterLabel.snp.makeConstraints { (make) in
                make.center.equalToSuperview()
            }
            
        }
       
}
