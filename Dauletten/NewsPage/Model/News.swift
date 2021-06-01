//
//  News.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/22/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class News: Codable {
    var id: Int
    var cat_id: Int
    var images: [String]
    var title: String
    var description: String?
    var videos: [String]?
    var show: Int
    var created_at: String?
    var updated_at: String?
}
