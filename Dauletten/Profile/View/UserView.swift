//
//  UserView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class UserView: UIView {

    var userAvatarView = UserAvatarView()
    var usernameLabel = UILabel()
    var phoneLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UserView: ViewInstallation {
    func addSubviews() {
        addSubview(userAvatarView)
        addSubview(usernameLabel)
        addSubview(phoneLabel)
    }
    
    func addConstraints() {
        userAvatarView.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.bottom.top.equalToSuperview()
            make.height.width.equalTo(64)
        }
        usernameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userAvatarView.snp.right).offset(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(self.snp.centerY).offset(-2)
        }
        phoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(userAvatarView.snp.right).offset(16)
            make.right.equalTo(-16)
            make.top.equalTo(self.snp.centerY).offset(2)
        }

    }
    
    func stylizeViews() {
        usernameLabel.textColor = .white
        usernameLabel.font = .getMontserratMediumFont(on: 17)
        usernameLabel.text = "Eldor Makkambayev"
        
        phoneLabel.textColor = .white
        phoneLabel.font = .getMontserratMediumFont(on: 13)
        phoneLabel.text = "+7 (700)-247-99-01"
        
        userAvatarView.letterLabel.text = String(describing: usernameLabel.text!.first!)
    }
    
    
}
