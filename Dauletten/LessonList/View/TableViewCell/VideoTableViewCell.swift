//
//  CategoryTableViewCell.swift
//  AidynNury
//
//  Created by Eldor Makkambayev on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

//    MARK: - Properties
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .upperColor
        view.layer.cornerRadius = 10
        
        return view
    }()

    
    lazy var playImageview: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 16
        image.layer.masksToBounds = true
        image.image = #imageLiteral(resourceName: "Group 10467")

        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserratMediumFont(on: 15)
        label.textColor = .white
        label.numberOfLines = 3
        
        return label
    }()
    
    lazy var countLabelButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Vector"), for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.741, green: 0.741, blue: 0.741, alpha: 1), for: .normal)
        button.titleLabel?.font = UIFont.getMontserratRegularFont(on: 11)
        button.contentHorizontalAlignment = .left

        
        return button
    }()
    
//    MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: _ Setup functions
    private func setupView() -> Void {
        selectionStyle = .none
        backgroundColor = .clear
        
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(8)
            make.left.equalTo(16)
            make.right.equalTo(-15)
            make.bottom.equalTo(-8)
        }
        
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.equalTo(12)
            make.right.equalTo(-56)
        }

        backView.addSubview(countLabelButton)
        countLabelButton.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.height.equalTo(11)
            make.width.equalTo(100)
            make.bottom.equalTo(-12)
        }
        
        backView.addSubview(playImageview)
        playImageview.snp.makeConstraints { (make) in
            make.height.width.equalTo(32)
            make.centerY.equalToSuperview()
            make.right.equalTo(-12)
        }
        
        
    }
            
    func configuration(video: Lesson, isFree: Bool) -> Void {
        self.playImageview.alpha = isFree ? 1.0 : 0.5
        titleLabel.text = video.title
        countLabelButton.setTitle("  \(video.show)", for: .normal)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
