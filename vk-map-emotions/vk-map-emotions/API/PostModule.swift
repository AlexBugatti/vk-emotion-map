//
//  PostModule.swift
//  vk-map-emotions
//
//  Created by Александр on 19.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation

extension API {
    
    class PostModule {
        
        class func getPosts(completion: @escaping (([Post])->Void)) {
            API.request("posts", method: .get) { (response) in
                guard let postJSON = response["data"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                let posts = postJSON.compactMap({ Post(from: $0) })
                completion(posts)
            }
        }
        
        class func create(parameters: [String: Any], completion: @escaping (([Post])->Void)) {
            API.request("posts", parameters: parameters, method: .post) { (response) in
                guard let postJSON = response["data"] as? [[String: Any]] else {
                    completion([])
                    return
                }
                
                let posts = postJSON.compactMap({ Post(from: $0) })
                completion(posts)
            }
        }
        
    }
    
}
