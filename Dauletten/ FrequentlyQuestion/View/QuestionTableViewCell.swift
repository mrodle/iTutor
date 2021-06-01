//
//  QuestionTableViewCell.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 11/13/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    //    MARK: - Preporties
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .upperColor
        view.layer.cornerRadius = 16
        if #available(iOS 11.0, *) {
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        } else {
            // Fallback on earlier versions
        }
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.getSFProRegularFont(on: 15)
        label.backgroundColor = .clear
        label.textAlignment = .left
        label.numberOfLines = 0
        
        return label
    }()

    //MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup function
    private func setupView() -> Void {
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.left.equalTo(24)
            make.top.equalTo(-8)
            make.bottom.equalToSuperview()
        }
        backView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 8, left: 24, bottom: 24, right: 24))
        }
    }
}
