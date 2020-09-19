//
//  Post.swift
//  vk-map-emotions
//
//  Created by Александр on 18.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import UIKit
import MapKit

class Post: NSObject, MKAnnotation {
    var content: String?
    var mood: MoodType
    var subject: Subject
    var latitude: Double
    var longitude: Double
    
    var imageURL: String?
    var authorName: String?
    var authorAvatar: String?
    var picture: String?
    var countComments: Int? = 0
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(self.latitude, self.longitude)
    }
    var title: String? {
        return "Категория"
    }
    
//    latitude47.5124
//    longitude16.712
//    subjecttourism
//    moodgood
//    author_nameIgor Kondrashov
//    author_avatarhttps://sun9-39.userapi.com/c853628/v853628532/181148/sHYZUg7z9yU.jpg
//    count_likes0
//    count_comments0
//    count_reposts0
//    picturehttps://sun9-32.userapi.com/NyEa9Eqn-bIg2vEUtdGQTLP119s7fF_3ug6gTA/7P2AIlesZz8.jpg?ava=1
    
    init?(from map: [String: Any]) {
        guard let subject = map["subject"] as? String,
              let mood = map["mood"] as? String,
              let moodType = MoodType(rawValue: mood),
              let latitude = map["latitude"] as? Double,
              let longitude = map["longitude"] as? Double else {
                return nil
        }
        
        self.subject = Subject(type: subject)
        self.mood = moodType
        self.latitude = latitude
        self.longitude = longitude
        
        self.authorName = map["author_name"] as? String
        self.authorAvatar = map["author_avatar"] as? String
        self.picture = map["picture"] as? String
        self.content = map["content"] as? String
        self.countComments = map["content"] as? Int
    }
    
    init(text: String, mood: MoodType, subject: Subject, latitude: Double, longitude: Double) {
        self.content = text
        self.mood = mood
        self.subject = subject
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func mock() -> [Post] {
        let post = Post(text: "Мой пост", mood: MoodType.good, subject: Subject.games, latitude: 33.32434, longitude: 54.345345)

        return [post]
    }
    
}
