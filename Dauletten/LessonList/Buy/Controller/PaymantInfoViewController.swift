//
//  PaymantInfoViewController.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/22/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class PaymantInfoViewController: UIViewController {
    
    var toLoginPageClosure: (() -> ()) = {}
    private var product: Category
        
    private var blurBlackView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        return view
    }()
    
    
    private var backView = UIView()
    
    lazy var scrollView = UIScrollView()
    lazy var contentView: UIView = {
        let view = UIView()

        return view
    }()

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
    private var contextLabel : UILabel = {
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
    private var phoneNumberButton: UIButton = {
        let button = UIButton()
//        button.setTitle("+7 (747) 942-18-76", for: .normal)
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
    private var kaspiPhoneNumberButton: UIButton = {
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
    private var kaspiCardNumberButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .getMontserratRegularFont(on: 17)
        button.setTitleColor(.white, for: .normal)

        return button
    }()
    private var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .upperColor
        button.setTitle("Түсіндім", for: .normal)
        button.layer.cornerRadius = 10
        button.setTitleColor(.mainColor, for: .normal)
        button.titleLabel?.font = .getMontserratMediumFont(on: 17)
        button.addTarget(self, action: #selector(toLoginPage), for: .touchUpInside)
        
        return button
    }()
    
    private var whatsappLinkLabel : UILabel = {
        let label = UILabel()
        label.text = "Сабаққа жазылу үшін  сілтемені басыңыз"
        label.textAlignment = .center
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white
        label.numberOfLines = 0

        return label
    }()
    
    private var whatsappLinkButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .getMontserratRegularFont(on: 17)
        button.setTitleColor(#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(whatsappLinkAction), for: .touchUpInside)

        return button
    }()
    
    private var whoIsReplyLabel : UILabel = {
        let label = UILabel()
        label.text = "(Менеджер Бекарыс жауап береді)"
        label.textAlignment = .center
        label.font = .getMontserratRegularFont(on: 17)
        label.textColor = .white
        label.numberOfLines = 0

        return label
    }()

    private var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        button.addTarget(self, action: #selector(dismissAction), for: .touchUpInside)
        return button
    }()
    

    init(product: Category) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getWarningInfo()
    }
    
    private func getWarningInfo() -> Void {
        ParseManager.shared.getRequest(url: AppConstants.API.setting, success: { (result: Warning) in
            self.contextLabel.text = "\"\(self.product.title)\" курсын сатып алу үшін \(self.product.price) теңге төлеп маған чекті whatsapp-қа жіберіңіз. Сол кезде сізге доступ жібереміз."
            self.kaspiCardNumberButton.setTitle(result.kaspi, for: .normal)
            self.phoneNumberButton.setTitle(result.whatsapp, for: .normal)
            self.kaspiPhoneNumberButton.setTitle(result.qiwi, for: .normal)
            self.whatsappLinkButton.setTitle(result.whatsapp_link, for: .normal)

        }) { (error) in
            self.showAlert(type: .error, error)
        }
    }
    
    @objc func dismissAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func toLoginPage() {
        if UserManager.getCurrentUser() == nil {
            self.dismiss(animated: true, completion: {
                self.toLoginPageClosure()
            })
        } else {
            self.dismiss(animated: true, completion: nil)
        }
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

extension PaymantInfoViewController {
    private  func setupViews() {
        addSubviews()
        addConstraints()
        stylizeViews()
        setupAction()
    }
    
    private func addSubviews() {
        view.addSubview(blurBlackView)
        view.addSubview(backView)
        backView.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(warningIcon)
        contentView.addSubview(warningLabel)
        contentView.addSubview(contextLabel)
        contentView.addSubview(whatsappLabel)
        contentView.addSubview(phoneNumberButton)
        contentView.addSubview(kaspiPhoneLabel)
        contentView.addSubview(kaspiPhoneNumberButton)
        contentView.addSubview(kaspiCardLabel)
        contentView.addSubview(kaspiCardNumberButton)
        contentView.addSubview(whatsappLinkLabel)
        contentView.addSubview(whatsappLinkButton)
        contentView.addSubview(whoIsReplyLabel)
        contentView.addSubview(okButton)
        contentView.addSubview(closeButton)
    }
    
    private func addConstraints() {
        
        blurBlackView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        backView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.85)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }

        scrollView.snp.makeConstraints { (make) in
            make.height.width.left.top.right.bottom.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(backView)
        }

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
            make.top.equalTo(whatsappLinkLabel.snp.bottom).offset(16)
        }
        
        whoIsReplyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(kaspiCardLabel)
            make.right.equalTo(-16)
            make.top.equalTo(whatsappLinkButton.snp.bottom).offset(8)
        }

        okButton.snp.makeConstraints { (make) in
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            make.top.equalTo(whoIsReplyLabel.snp.bottom).offset(8)
            make.bottom.lessThanOrEqualTo(-16)
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.equalTo(12)
            make.height.width.equalTo(24)
        }
    }
    
    private func setupAction() -> Void {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissAction))
        blurBlackView.addGestureRecognizer(tap)
    }

    private func stylizeViews() {
        view.backgroundColor = .clear
        backView.backgroundColor = .backColor
        backView.layer.cornerRadius = 16
        
    }
    
}
