//
//  User.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 7/13/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
struct User: Codable {
    var id: Int
    var name: String?
    var email: String?
    var token: String?
}
