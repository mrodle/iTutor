//
//  QuestionModel.swift
//  VideoHosting
//
//  Created by Eldor Makkambayev on 11/13/19.
//  Copyright © 2019 Eldor Makkambayev. All rights reserved.
//

import Foundation
class QuestionModel: Codable {
    var result: [Question]
}

class Question: Codable {
    var id: Int
    var question: String?
    var answer: String
    
    init(id: Int, question: String?, answer: String) {
        self.id = id
        self.question = question
        self.answer = answer
    }
    
}
