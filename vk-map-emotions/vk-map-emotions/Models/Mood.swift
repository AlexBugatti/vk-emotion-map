//
//  Mood.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

enum MoodType: String {
    case something = "something"
    case good = "good"
    case sad = "sad"
    case cheerful = "cheerful"
    case slack = "slack"
}

struct Mood {
    var name: String
    var emoji: String
    var type: MoodType
    
    static var something: Mood {
        return Mood(name: "Любое", emoji: "😶", type: .something)
    }
    static var good: Mood {
        return Mood(name: "Веселое", emoji: "😀", type: .good)
    }
    static var sad: Mood {
        return Mood(name: "Грустное", emoji: "🙁", type: .sad)
    }
    static var cheerful: Mood {
        return Mood(name: "Бодрое", emoji: "😜", type: .cheerful)
    }
    static var slack: Mood {
        return Mood(name: "Вялое", emoji: "😴", type: .slack)
    }
    
    static var all: [Mood] = [Mood.something, Mood.good, Mood.sad, Mood.cheerful, Mood.slack]
}
