//
//  FeedbackViewController.swift
//  VideoLessons
//
//  Created by Eldor Makkambayev on 2/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit
import MessageUI

class FeedbackViewController: LoaderBaseViewController {
//    MARK: - Properties
    

    lazy var phoneSelection: FeedbackSelectionView = {
        let view = FeedbackSelectionView(image: #imageLiteral(resourceName: "phone-2"), title: "+7 700 247 99 01")
        view.buttonTarget = {
            guard let number = URL(string: "tel://" + view.selectorButton.titleLabel!.text!) else { return }
            UIApplication.shared.open(number)
        }
        return view
    }()
    
    lazy var emailSelection: FeedbackSelectionView = {
        let view = FeedbackSelectionView(image: #imageLiteral(resourceName: "gmail"), title: "apple.eldor@gmail.com")
        view.buttonTarget = {
            guard let email = view.selectorButton.titleLabel?.text else { return }
                    if MFMailComposeViewController.canSendMail() {
                        let mail = MFMailComposeViewController()
                        mail.mailComposeDelegate = self as? MFMailComposeViewControllerDelegate
                        mail.setToRecipients([email])
                        mail.setMessageBody("", isHTML: true)
                        self.navigationController?.present(mail, animated: true)
                    }
        }

        return view
    }()

    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = .upperColor
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        
        return view
    }()
    
//    MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationController?.navigationBar.isHidden = false
        setNavBarWithLarge(title: "Кері байланыс", isLargeTitle: false)
    }
    
    override func configureViews() {
        setupView()
        getFeedbackData()
    }
    

//    MARK: - Setup function
    private func setupView() -> Void {
        view.backgroundColor = .backColor
        
        view.addSubview(backView)
        backView.snp.makeConstraints { (make) in
            make.top.equalTo(24)
            make.left.equalTo(16)
            make.right.equalTo(-16)
        }
        
        backView.addSubview(phoneSelection)
        phoneSelection.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(24)
        }
        
        backView.addSubview(emailSelection)
        emailSelection.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(phoneSelection.snp.bottom).offset(32)
            make.bottom.equalTo(-24)
        }

    }
    
    private func getFeedbackData() -> Void {
        self.showLoader()
        ParseManager.shared.getRequest(url: AppConstants.API.getSetting, success: { (result: Feedback) in
            self.phoneSelection.selectorButton.setTitle(result.phone, for: .normal)
            self.emailSelection.selectorButton.setTitle(result.email, for: .normal)
            self.hideLoader()
        }) { (error) in
            self.showErrorMessage(error)
        }
    }

    
}
