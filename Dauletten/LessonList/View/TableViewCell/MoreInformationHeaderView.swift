//
//  MoreInformationHeaderView.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 4/14/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class MoreInformationHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    var isOpen = false {
        didSet {
            UIView.animate(withDuration: 0.5) {
                if !self.isOpen {
                    self.backView.layer.cornerRadius = 16
                    if #available(iOS 11.0, *) {
                        self.backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMaxYCorner]
                    } else {
                        // Fallback on earlier versions
                    }
                    
                    
                } else {
                    self.backView.layer.cornerRadius = 16
                    self.backView.layer.masksToBounds = true
                    if #available(iOS 11.0, *) {
                        self.backView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
                
            }
        }
    }
    var actionEvent = {()->() in}
    lazy var backView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.backgroundColor = .upperColor
        
        return view
    }()
    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.textColor = .white
        title.font = .getMontserratMediumFont(on: 14)
        title.textAlignment = .left
        title.numberOfLines = 0
        title.text = "Курс бойынша ақпарат"
        
        return title
    }()
    
    lazy var hideButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Group-4"), for: .normal)
        
        return button
    }()
    
    lazy var actionButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    //MARK: - Initialization
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .backColor
        tintColor = .backColor
        setupViews()
        setupAction()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup functions
    private func setupViews() {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.bottom.top.equalToSuperview()
            make.height.equalTo(44)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(22)
            make.centerY.equalToSuperview()
            make.right.equalTo(-54)
        }
        backView.addSubview(hideButton)
        hideButton.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.height.width.equalTo(16)
            make.centerY.equalTo(titleLabel)
        }
        backView.addSubview(actionButton)
        actionButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
    }
    
    private func setupAction() -> Void {
        actionButton.addTarget(self, action: #selector(actionLabel), for: .touchUpInside)
    }
    
    //MARK: - Objective function
    @objc func actionLabel() {
        isOpen.toggle()
        self.actionEvent()

    }
    
    
}

