//
//  QuestionHeaderView.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 11/13/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class QuestionHeaderView: UITableViewHeaderFooterView {
    
    //MARK: - Properties
    var isOpen = false
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
        title.font = .getSFProSemiboldFont(on: 15)
        title.textAlignment = .left
        title.numberOfLines = 0
        
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
        backgroundColor = .clear
        tintColor = .clear
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
            make.top.equalTo(8)
            make.left.equalTo(24)
            make.right.equalTo(-24)
            make.bottom.equalTo(0)
        }
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.top.equalTo(24)
            make.bottom.equalTo(-16)
            make.right.equalTo(-52)
        }
        backView.addSubview(hideButton)
        hideButton.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.height.width.equalTo(10)
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
        UIView.animate(withDuration: 0.5) {
            if self.isOpen {
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
            self.actionEvent()
            
        }
        isOpen.toggle()
    }
    
    
}
