//
//  Tematic.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit

enum Subject: String {
    case it = "IT"
    case tourism = "Туризм"
    case sport = "Спорт"
    case games = "Игры"
    case style = "Стиль"
    case music = "Музыка"
    case humor = "Юмор"
    case films = "Кино"
    case photo = "Фото"
    case science = "Наука"
    case art = "Арт"
    
    init(type: String) {
        switch type {
            case "it": self = .it
            case "tourism": self = .tourism
            case "sport": self = .sport
            case "games": self = .games
            case "style": self = .style
            case "music": self = .music
            case "humor": self = .humor
            case "films": self = .films
            case "photo": self = .photo
            case "science": self = .science
            case "art": self = .art
            default: self = .it
        }
    }
    
    func toEmodji() -> String {
        switch self {
        case .it: return "🖥"
        case .tourism:  return "🌍"
        case .sport:  return "⚽"
        case .games:  return "💿"
        case .style:  return "🕶"
        case .music:  return "🎵"
        case .humor:  return "😀"
        case .films:  return "📽"
        case .photo:  return "📷"
        case .science:  return "🚀"
        case .art:  return "🖼"
        }
    }
    
    static let allValues = [it,tourism,sport,games,style,music,humor,films,photo,science,art]
}
