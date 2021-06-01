//
//  Category.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class Category: Codable {
    var id: Int
    var title: String
    var description: String?
    var price: Int
    var image: String?
    var author: String?
    var lesson_count: Int
    var bought: Bool
}

class Lesson: Codable {
    var id: Int
    var show: Int
    var video_fon: String?
    var title: String
}
