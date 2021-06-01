//
//  SearchNavBar.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class SearchNavBar: UIView {
    
    //    MARK: - Properties
    
    var goBack: (() -> ())?
    lazy var searchView: SearchView = {
        let view = SearchView()
        

//        view.layer.shadowColor = UIColor(red: 0.047, green: 0.129, blue: 0.212, alpha: 0.04).cgColor
//        view.layer.shadowOffset = CGSize(width: 0, height: 4.0)
//        view.layer.shadowOpacity = 1.0
//        view.layer.shadowRadius = 32.0
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = false

        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "Combined Shape-5"), for: .normal)
        button.contentMode = .scaleAspectFit
        
        return button
    }()
    
//    MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //    MARK: - Setup functions

    private func setupAction() -> Void {
        backButton.addTarget(self, action: #selector(goToBack), for: .touchUpInside)
    }
    
    @objc func goToBack() -> Void {
        self.goBack?()
    }
    
}

extension SearchNavBar: ViewInstallation {
    func addSubviews() {
        addSubview(searchView)

    }
    
    func addConstraints() {
        searchView.snp.makeConstraints { (make) in
            make.top.equalTo(4)
            make.left.equalTo(16)
            make.right.equalTo(-16)
            make.height.equalTo(44)
            make.bottom.equalTo(-4)
        }

    }
    
    func stylizeViews() {
        self.backgroundColor = .backColor
    }
    
    
}
