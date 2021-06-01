//
//  InputView.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 12/19/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import UIKit
enum InputTypes {
    case phone
    case plainText
    case secureText
    
    var isSecure: Bool {
        return .secureText == self
    }
}

class InputView: UIView {
    
    //MARK: - Properties
    let inputType: InputTypes
    var placeholder: String
    private let icon: UIImage?
    var iconAction: (() -> ())?

    lazy var textField: UITextField = {
        let tf = UITextField()
        tf.isSecureTextEntry = inputType.isSecure
        tf.borderStyle = .none
        tf.font = .getMontserratMediumFont(on: 17)
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
        attributes: [
            NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 0.929, green: 0.922, blue: 0.969, alpha: 1),
          NSAttributedString.Key.font: UIFont.getMontserratMediumFont(on: 17)])

        return tf
    }()
    
    lazy var phoneTextField: PhoneTextField = {
        let tf = PhoneTextField()
        tf.isSecureTextEntry = inputType.isSecure
        tf.borderStyle = .none
        tf.font = .getMontserratMediumFont(on: 17)
        tf.textColor = .white
        tf.backgroundColor = .clear
        tf.attributedPlaceholder = NSAttributedString(string: placeholder,
        attributes: [
            NSAttributedString.Key.foregroundColor:  #colorLiteral(red: 0.929, green: 0.922, blue: 0.969, alpha: 1),
          NSAttributedString.Key.font: UIFont.getMontserratMediumFont(on: 17)])

        return tf
    }()

    lazy var iconView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = icon
        iv.isUserInteractionEnabled = true
        
        return iv
    }()

    //MARK: - Initialization
    init(inputType: InputTypes, icon: UIImage? = nil, placeholder: String) {
        self.inputType = inputType
        self.icon = icon
        self.placeholder = placeholder
        super.init(frame: .zero)
        setupViews()
        setupGesture()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    private func setupViews() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .upperColor
        self.layer.borderColor = UIColor.mainColor.cgColor
        self.layer.borderWidth = 0.5
        
        if inputType == .phone {
            self.addSubview(self.phoneTextField)
            self.phoneTextField.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(16)
                make.right.equalTo(-8)
            }
        } else {
            self.addSubview(self.textField)
            self.textField.snp.makeConstraints { (make) in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(16)
                make.right.equalTo(-8)
            }
        }
        
        addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-10)
            make.height.width.equalTo(23)
        }

    }
    
    private func setupGesture() -> Void {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(iconTarget))
        iconView.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func iconTarget() -> Void {
        iconAction?()
    }


}
