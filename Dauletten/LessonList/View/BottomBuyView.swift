//
//  BottomBuyView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class BottomBuyView: UIView {
    
    var buyButton = UIButton()
    var priceTitleLabel = UILabel()
    var priceLabel = UILabel()
//    var oldPriceLabel = UILabel()
//    var oldPriceUpperView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension BottomBuyView: ViewInstallation {
    func addSubviews() {
        addSubview(buyButton)
        addSubview(priceLabel)
        addSubview(priceTitleLabel)
//        addSubview(oldPriceLabel)
//        addSubview(oldPriceUpperView)
    }
    
    func addConstraints() {
        buyButton.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-16)
            make.height.equalTo(40)
            make.bottom.equalTo(-16)
            make.width.equalTo(AppConstants.screenWidth * 200 / 375)
        }
        
        priceLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(buyButton)
            make.left.equalTo(16)
        }
        
        priceTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.left.equalTo(16)
            make.bottom.equalTo(priceLabel.snp.top).offset(-4)
        }
    }
    
    func stylizeViews() {
        backgroundColor = .upperColor
        
        buyButton.backgroundColor = .mainColor
        buyButton.layer.cornerRadius = 10
        buyButton.setTitle("Сатып алу", for: .normal)
        buyButton.setTitleColor(.black, for: .normal)
        buyButton.titleLabel?.font = .getMontserratMediumFont(on: 13)
        
        priceTitleLabel.text = "Курс бағасы:"
        priceTitleLabel.textColor = #colorLiteral(red: 0.929, green: 0.922, blue: 0.969, alpha: 1)
        priceTitleLabel.font = .getMontserratMediumFont(on: 13)

        priceLabel.textColor = .mainColor
        priceLabel.font = .getMontserratSemiBoldFont(on: 20)
        priceLabel.text = "15 990 тг"
    }
    
    
}
