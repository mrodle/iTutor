//
//  CoursesTableViewCell.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class CoursesTableViewCell: UITableViewCell {

//    MARK: - Properties
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .upperColor
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    lazy var imageview: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        if #available(iOS 11.0, *) {
            image.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        } else {
            // Fallback on earlier versions
        }
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.image = #imageLiteral(resourceName: "Rectangle 90")

        return image
    }()

    lazy var premiumImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "crown")
        
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserratMediumFont(on: 18)
        label.textColor = .textColor
        label.numberOfLines = 0
        label.text = "Баспанаға бағыт"
        
        return label
    }()
    
    lazy var countOfLessonsLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserratRegularFont(on: 15)
        label.textColor = .textColor
        label.text = "21 уроков"
        
        return label
    }()


// MARK: - Initialization
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//AMRK: - Setup function
    private func setupView() -> Void {
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(12)
            make.bottom.equalTo(-12)
            make.left.equalTo(24)
            make.right.equalTo(-24)
        }
        backView.addSubview(imageview)
        imageview.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo((AppConstants.screenWidth - 48) / 2)
        }
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-48)
            make.top.equalTo(imageview.snp.bottom).offset(16)
        }
        backView.addSubview(countOfLessonsLabel)
        countOfLessonsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.bottom.equalTo(-12)
        }

        backView.addSubview(premiumImage)
        premiumImage.snp.makeConstraints { (make) in
            make.right.equalTo(-24)
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(17)
            make.height.equalTo(12)
        }
    }
    
    func configuration(category: Category, index: Int, isMy: Bool = false) -> Void {
        titleLabel.text = category.title
        countOfLessonsLabel.text = "Жиыны: \(category.lesson_count) видео"
        premiumImage.image = category.bought ? #imageLiteral(resourceName: "Combined Shape-6") : #imageLiteral(resourceName: "crown")
        premiumImage.isHidden = isMy
        if let url = category.image {
            imageview.kf.setImage(with: URL(string: url.serverUrlString))
        } else {
            imageview.image = #imageLiteral(resourceName: "no_image")
        }
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
