//
//  NewsTableViewCell.swift
//  AidynNury
//
//  Created by Eldor Makkambayev on 2/3/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import Kingfisher

class NewsTableViewCell: UITableViewCell {
    
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
        image.layer.cornerRadius = 8
        image.layer.masksToBounds = true
        image.image = #imageLiteral(resourceName: "Rectangle 90")

        return image
    }()
    
    lazy var watchCountIcon: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "Vector"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    lazy var watchCountLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProSemiboldFont(on: 13)
        label.textColor = #colorLiteral(red: 0.737, green: 0.776, blue: 0.827, alpha: 1)
        label.numberOfLines = 0
        
        return label
    }()

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .getMontserratSemiBoldFont(on: 15)
        label.textColor = .white
        label.numberOfLines = 2
        
        return label
    }()
    
    lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = .getSFProSemiboldFont(on: 13)
        label.textColor = #colorLiteral(red: 0.737, green: 0.776, blue: 0.827, alpha: 1)
        label.numberOfLines = 0
        
        return label
    }()

    
//    MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//   MARK: - Setup function
    private func setupView() -> Void {
        selectionStyle = .none
        backgroundColor = .clear
        addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        backView.addSubview(imageview)
        imageview.snp.makeConstraints { (make) in
            make.top.equalTo(16)
            make.bottom.equalTo(-16)
            make.left.equalTo(16)
            make.width.equalTo(80)
            make.height.equalTo(72)
        }
        
        backView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageview.snp.right).offset(16)
            make.right.equalTo(-8)
            make.top.equalTo(imageview)
        }

        backView.addSubview(watchCountLabel)
        watchCountLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.bottom.equalTo(-12)
        }
        
        backView.addSubview(watchCountIcon)
        watchCountIcon.snp.makeConstraints { (make) in
            make.right.equalTo(watchCountLabel.snp.left).offset(-4)
            make.height.equalTo(10)
            make.width.equalTo(14)
            make.centerY.equalTo(watchCountLabel)
        }
        
        backView.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(watchCountLabel)
            make.left.equalTo(titleLabel)
        }

    }
    
    func configuration(news: News) -> Void {
        titleLabel.text = news.title
        watchCountLabel.text = "\(news.show)"
        dateLabel.text = getDate(news.created_at)
        
        if !news.images.isEmpty {
            imageview.kf.setImage(with: URL(string: news.images.first!.serverUrlString))
        } else {
            imageview.image = #imageLiteral(resourceName: "no_image")
        }
    }
    
    func getDate(_ date: String?) ->String {
        let monthList = ["қаңтар", "ақпан", "наурыз", "сәуір", "мамыр", "маусым", "шілде", "тамыз", "қыргүйек", "қазан", "қараша", "желтоқсан"]
        var dateString = ""
        guard let date = date else { return dateString}
        let year = date.prefix(4)
        let monthIndex = Int(String(date.suffix(date.count - 5)).prefix(2))
        let day = String(date.suffix(date.count - 8)).prefix(2)
        
        dateString = "\(Int(day) ?? 0) \(monthList[(monthIndex ?? 1)-1]), \(year)"

        return dateString
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
