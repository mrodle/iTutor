//
//  TabNavBarView.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/15/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import UIKit

class TabNavBarView: UIView {

//    MARK: - Properties
    
    var backView = UIView()
    var daulettenIcon = UIImageView(image: #imageLiteral(resourceName: "Group 242"))
    var separatorView = UIView()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension TabNavBarView: ViewInstallation {
    func addSubviews() {
        addSubview(backView)
        backView.addSubview(daulettenIcon)
    }
    
    func addConstraints() {
        backView.snp.makeConstraints { (make) in
            make.width.equalTo(AppConstants.screenWidth)
        }
        daulettenIcon.snp.makeConstraints { (make) in
            make.right.equalTo(-16)
            make.top.equalTo(5)
            make.bottom.equalTo(-5)
            make.width.height.equalTo(AppConstants.navBarHeight - 10)
        }
        
    }
    
    func stylizeViews() {
        daulettenIcon.contentMode = .scaleAspectFit
        
        backView.backgroundColor = .backColor
    }
    
    
}
