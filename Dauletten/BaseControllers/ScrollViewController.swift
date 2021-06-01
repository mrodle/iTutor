//
//  ScrollViewController.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit
import IQKeyboardManager

class ScrollViewController: UIViewController {
    
    //MARK: - Properties
    lazy var scrollView = UIScrollView()
    lazy var contentView: IQPreviousNextView = {
        let view = IQPreviousNextView()

        return view
    }()
    
    //MARK: - Lifecycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        hideKeyboardWhenTappedAround()
    }
    
    //MARK: - Setup functions
    func setupScrollView() {
        view.backgroundColor = .clear
        scrollView.backgroundColor = .clear
        contentView.backgroundColor = .clear

        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.snp.makeConstraints { (make) in
            make.height.left.top.right.bottom.equalToSuperview()
//            make.height.equalTo(view.bounds.height + AppConstants.statusBarHeight)
//            make.top.equalTo(-AppConstants.statusBarHeight)
            make.width.equalTo(AppConstants.screenWidth)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
    }
    
    //MARK: - Simple functions
    func addToScrollView(_ views: [UIView]) -> Void {
        for view in views {
            scrollView.addSubview(view)
        }
    }
}
