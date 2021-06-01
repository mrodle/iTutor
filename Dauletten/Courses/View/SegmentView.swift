//
//  SegmentView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 04.09.2020.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class SegmentView: UIView {

//    MARK: - Properties
    var firstButtonTarget: (() -> ())?
    var secondButtonTarget: (() -> ())?
    var thirdButtonTarget: (() -> ())?
    
    var itemList: [String]
    var selectedButton: UIButton? {
        didSet{
            let buttons = [firstButton, secondButton, thirdButton]
            for button in buttons {
                button.setTitleColor(.mainColor, for: .normal)
                button.backgroundColor = .clear
            }
            self.selectedButton?.backgroundColor = .mainColor
            self.selectedButton!.setTitleColor(.backColor, for: .normal)
            
        }
    }
    lazy var firstButton: UIButton = {
        let button = UIButton()
//        button.layer.borderColor = UIColor.mainColor.cgColor
//        button.layer.borderWidth = 1
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .getSFProMediumFont(on: 19)
        button.backgroundColor = .white

        return button
    }()

    lazy var secondButton: UIButton = {
        let button = UIButton()
//        button.layer.borderColor = UIColor.mainColor.cgColor
//        button.layer.borderWidth = 1
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .getSFProMediumFont(on: 19)
        button.backgroundColor = .white

        return button
    }()

    lazy var thirdButton: UIButton = {
        let button = UIButton()
//        button.layer.borderColor = UIColor.mainColor.cgColor
//        button.layer.borderWidth = 1
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .getSFProMediumFont(on: 17)
        button.backgroundColor = .white

        return button
    }()

    init(_ items: [String]) {
        self.itemList = items
        super.init(frame: .zero)
        setupView()
        setupAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() -> Void {
        startAction()
        layer.cornerRadius = 5
        layer.borderColor = UIColor.mainColor.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        
        if itemList.count == 2 {
            firstButton.setTitle(itemList[0], for: .normal)
            secondButton.setTitle(itemList[1], for: .normal)
            
            addSubview(firstButton)
            firstButton.snp.makeConstraints { (make) in
                make.left.top.bottom.equalToSuperview()
                make.height.equalTo(32)
                make.width.equalTo(snp.width).dividedBy(2)
            }
            addSubview(secondButton)
            secondButton.snp.makeConstraints { (make) in
                make.right.top.bottom.equalToSuperview()
                make.height.equalTo(32)
                make.width.equalTo(snp.width).dividedBy(2)
            }
        } else {
            firstButton.setTitle(itemList[0], for: .normal)
            secondButton.setTitle(itemList[1], for: .normal)
            thirdButton.setTitle(itemList[2], for: .normal)

            addSubview(firstButton)
            firstButton.snp.makeConstraints { (make) in
                make.left.top.bottom.equalToSuperview()
                make.height.equalTo(32)
                make.width.equalTo(snp.width).dividedBy(3)
            }
            addSubview(secondButton)
            secondButton.snp.makeConstraints { (make) in
                make.centerX.top.bottom.equalToSuperview()
                make.height.equalTo(32)
                make.width.equalTo(snp.width).dividedBy(3)
            }
            addSubview(thirdButton)
            thirdButton.snp.makeConstraints { (make) in
                make.right.top.bottom.equalToSuperview()
                make.height.equalTo(32)
                make.width.equalTo(snp.width).dividedBy(3)
            }
        }
    }
    
    private func setupAction() -> Void {
        firstButton.addTarget(self, action: #selector(firstAction), for: .touchUpInside)
        secondButton.addTarget(self, action: #selector(secondAction), for: .touchUpInside)
        thirdButton.addTarget(self, action: #selector(thirdAction), for: .touchUpInside)

    }
    
//    MARK: - Simple functions
    func startAction() -> Void {
        firstAction()
    }
    
//    MARK: - OBJC FUNC
    
    @objc func firstAction() -> Void {
        self.selectedButton = firstButton
        self.firstButtonTarget?()
    }
    
    @objc func secondAction() -> Void {
        self.selectedButton = secondButton
        self.secondButtonTarget?()
    }
    
    @objc func thirdAction() -> Void {
        self.selectedButton = thirdButton
        self.thirdButtonTarget?()
    }
}
