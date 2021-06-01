//
//  WarningView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/16/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class WarningView: UIView {

    //MARK: - Properties
    var copyboardClosure = {()->() in}

    private var warningIcon: UIImageView = {
        let view = UIImageView(image: #imageLiteral(resourceName: "↳ Icon Color"))
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    private var warningLabel : UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Ескерту!".uppercased()
        label.font = .getMontserratSemiBoldFont(on: 20)

        return label
    }()
    lazy var contextLabel : UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.929, green: 0.922, blue: 0.969, alpha: 1)
        label.numberOfLines = 0
        label.font = .getMontserratRegularFont(on: 17)

        return label
    }()
    private var whatsappLabel : UILabel = {
        let label = UILabel()
        label.text = "Whatsapp: "
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white

        return label
    }()
    lazy var phoneNumberButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .getMontserratRegularFont(on: 17)
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    private var kaspiPhoneLabel : UILabel = {
        let label = UILabel()
        label.text = "Kaspi номер: "
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white

        return label
    }()
    lazy var kaspiPhoneNumberButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .getMontserratRegularFont(on: 17)
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    private var kaspiCardLabel : UILabel = {
        let label = UILabel()
        label.text = "Kaspi: "
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white

        return label
    }()
    lazy var kaspiCardNumberButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .getMontserratRegularFont(on: 17)
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    private var whatsappLinkLabel : UILabel = {
        let label = UILabel()
        label.text = "Сабаққа жазылу үшін сілтемені басыңыз"
        label.textAlignment = .center
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white
        label.numberOfLines = 0

        return label
    }()
    
    var whatsappLinkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .getMontserratRegularFont(on: 17)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(whatsappLinkAction), for: .touchUpInside)

        return button
    }()

    private var whoIsReplyLabel : UILabel = {
        let label = UILabel()
        label.text = "(Мұғалім жауап береді)"
        label.textAlignment = .center
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white
        label.numberOfLines = 0

        return label
    }()

    //MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
        setupAction()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - Setup functions
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    private func setupViews() {
        self.backgroundColor = .backColor
        self.layer.borderColor = UIColor.upperColor.cgColor
        self.layer.borderWidth = 1
        self.backgroundColor = .upperColor
        self.layer.cornerRadius = 16

        addSubview(warningIcon)
        addSubview(warningLabel)
        addSubview(contextLabel)
        addSubview(whatsappLabel)
        addSubview(phoneNumberButton)
        addSubview(kaspiPhoneLabel)
        addSubview(kaspiPhoneNumberButton)
        addSubview(kaspiCardLabel)
        addSubview(kaspiCardNumberButton)
        addSubview(whatsappLinkLabel)
        addSubview(whatsappLinkButton)
        addSubview(whoIsReplyLabel)
        
        warningIcon.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(30)
            make.height.equalTo(42)
            make.width.equalTo(44)
        }
        
        warningLabel.snp.makeConstraints { (make) in
            make.top.equalTo(warningIcon.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }

        contextLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(warningLabel.snp.bottom).offset(20)
            make.right.equalTo(-16)
        }
        
        whatsappLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(contextLabel.snp.bottom).offset(16)
        }

        phoneNumberButton.snp.makeConstraints { (make) in
            make.left.equalTo(whatsappLabel.snp.right).offset(4)
            make.centerY.equalTo(whatsappLabel)
        }

        kaspiPhoneLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(whatsappLabel.snp.bottom).offset(16)
        }

        kaspiPhoneNumberButton.snp.makeConstraints { (make) in
            make.left.equalTo(kaspiPhoneLabel.snp.right).offset(4)
            make.centerY.equalTo(kaspiPhoneLabel)
        }

        kaspiCardLabel.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.top.equalTo(kaspiPhoneLabel.snp.bottom).offset(16)
        }

        kaspiCardNumberButton.snp.makeConstraints { (make) in
            make.left.equalTo(kaspiCardLabel.snp.right).offset(4)
            make.centerY.equalTo(kaspiCardLabel)
        }
        
        whatsappLinkLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kaspiCardLabel)
            make.right.equalTo(-16)
            make.top.equalTo(kaspiCardLabel.snp.bottom).offset(16)
        }
        
        whatsappLinkButton.snp.makeConstraints { (make) in
            make.left.equalTo(kaspiCardLabel)
            make.right.equalTo(-16)
            make.height.greaterThanOrEqualTo(20)
            make.top.equalTo(whatsappLinkLabel.snp.bottom).offset(8)

        }
        
        whoIsReplyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kaspiCardLabel)
            make.right.equalTo(-16)
            make.bottom.equalTo(-16)
            make.top.equalTo(whatsappLinkButton.snp.bottom).offset(8)
        }
    }

    private func setupAction() -> Void {
        phoneNumberButton.addTarget(self, action: #selector(getNumberAction(_:)), for: .touchUpInside)
        kaspiCardNumberButton.addTarget(self, action: #selector(getNumberAction(_:)), for: .touchUpInside)
        kaspiPhoneNumberButton.addTarget(self, action: #selector(getNumberAction(_:)), for: .touchUpInside)
    }

    @objc func getNumberAction(_ sender: UIButton) -> Void {
        UIPasteboard.general.string = sender.titleLabel?.text
        copyboardClosure()
    }
    
    @objc func whatsappLinkAction(_ sender: UIButton) {
        if let url = URL(string: sender.titleLabel!.text ?? "") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.open(url)
            }
        }
    }
}
