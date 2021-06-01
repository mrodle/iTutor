//
//  SearchView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class SearchView: UIView {

//    MARK: - Properties

    lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .clear
        textField.attributedPlaceholder = NSAttributedString(string: "Сабақтарды іздеу", attributes: [NSAttributedString.Key.foregroundColor:  UIColor.white, NSAttributedString.Key.font: UIFont.getSFProRegularFont(on: 16)])
        textField.font = UIFont.getSFProRegularFont(on: 16)
        textField.textColor = .white
        
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Combined Shape-4"), for: .normal)
        button.tintColor = .mainColor
        
        return button
    }()
    
//MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Setup functions

    private func setupView() -> Void {
        self.backgroundColor = .upperColor
        
        addSubview(searchButton)
        searchButton.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalToSuperview()
            make.height.width.equalTo(16)
        }
        addSubview(searchTextField)
        searchTextField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(-30)
            make.left.equalTo(16)
        }

    }

}
