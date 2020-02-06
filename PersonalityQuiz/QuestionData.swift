//
//  QuestionData.swift
//  PersonalityQuiz
//
//  Created by Christopher Gantt on 2/5/20.
//  Copyright © 2020 Christopher Gantt. All rights reserved.
//

import Foundation

struct Question {
    var text: String
    var type: ResponseType
    var answers: [Answer]
}

enum ResponseType {
    case single, multiple, ranged
}

struct Answer {
    var text: String
    var type: MusicType
}

enum MusicType: String {
    case metal = "Metal", jazz = "Jazz", experimental = "Experimental", songwriter = "Singer/Songwriter"
    
    var definition: String {
            switch self {
            case .metal:
                return "You live loud! Life can be brutal, but for a metalhead that's not exactly a bad thing."
            case .jazz:
                return "You strive to express your inner feelings with freeform melodies but this is thanks in part to that groove that helps keep you afloat."
            case .experimental:
                return "You break the norm. Exploration of what hasn't been done is essential for progress."
            case .songwriter:
                return "Expressing your feelings through meticulously crafted words and melodies connects you to those around you."
        }
    }
}
