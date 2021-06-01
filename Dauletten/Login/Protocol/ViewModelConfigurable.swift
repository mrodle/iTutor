//
//  ViewModelConfigurable.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation

protocol ViewModelConfigurable {
    var errorMessage: String {get set}
    var parameters: Parameters {get set}
    func getParameters() -> Parameters?
    func isValid() -> Bool
}
