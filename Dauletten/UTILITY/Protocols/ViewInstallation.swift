//
//  ViewInstallation.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import Foundation
import Foundation

protocol ViewInstallation {
    func addSubviews()
    func addConstraints()
    func stylizeViews()
}

extension ViewInstallation {
    func setupViews() {
        addSubviews()
        addConstraints()
        stylizeViews()
    }
}
