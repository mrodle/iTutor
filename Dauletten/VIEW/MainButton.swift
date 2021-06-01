//
//  MainButton.swift
//  Santo
//
//  Created by Eldor Makkambayev on 9/26/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
import UIKit

class MainButton: UIButton {
    
    //MARK: - Initialization
    init(title: String) {
        super.init(frame: .zero)
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = .getMontserratMediumFont(on: 17)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .mainColor
        self.layer.cornerRadius = 15
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
