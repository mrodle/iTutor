//
//  PushModel.swift
//  Dauletten
//
//  Created by Eldor Makkambayev on 03.10.2020.
//  Copyright © 2020 Eldor Makkambayev. All rights reserved.
//

import Foundation
import SwiftyJSON

class PushModel: Codable {
    var title: String
    var body: String
    var type: String
    var id: Int
    
    init(json: JSON) {
        title = json["title"].stringValue
        body = json["body"].stringValue
        type = json["type"].stringValue
        id = json["id"].intValue
    }
}

enum PushOpenType: String {
    case news = "post"
    case questionAnswer = "questionAnswer"
//    case video = "course"
    
    func openType(id: Int) {
        switch self {
        case .news:
            AppCenter.shared.getNewsFromPush(id: id)
        case .questionAnswer:
            AppCenter.shared.getQuestionAnswerFromPush()
        }
    }
}
