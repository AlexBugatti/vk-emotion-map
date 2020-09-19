//
//  API.swift
//  vk-map-emotions
//
//  Created by Александр on 19.09.2020.
//  Copyright © 2020 AlexBugatti. All rights reserved.
//

import Foundation
import Alamofire

class API {
    
    enum Endpoint: String {
        case debug = "https://donate091.herokuapp.com/"
    }
    
    static var url: Endpoint {
        return Endpoint.debug
    }
    
    static func request(_ path: String, parameters: [String: Any]? = nil, method: HTTPMethod = .get, requestEnd: @escaping ([String: Any]) -> ()) {

        let headers = ["Content-Type": "application/json"]
        var _response: [String: Any] = [:]

        Alamofire.request(url.rawValue + path, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            _response = getResponse(from: response)
            requestEnd(_response)
        }
    }
    
    private static func getResponse(from response: DataResponse<Any>) -> [String: Any] {
        
        let code = response.response?.statusCode
        
        guard code != 401 else {
            print("[API] Session is invalid")
            return ["errors": "Session is invalid"]
        }
        
        if code != 200 {
            print("[API] Bad status code: \(code ?? -1)")
        }
        
        guard let content = response.result.value as? [[String: Any]] else {
            print("[API] Can't get content from response")
            return [:]
        }
        
        let result = ["data": content]

        return result
    }
    
}
