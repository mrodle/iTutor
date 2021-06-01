//
//  Video.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 8/21/20.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
class Video: Codable {
    var id: Int
    var course_id: Int
    var title: String
    var description: String?
    var homework: String?
    var video_url: String?
    var video_fon: String?
    var audios: [String]?
    var homework_audios: [String]?
}

