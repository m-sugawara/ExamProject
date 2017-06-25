//
//  User.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/26.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
    let login: String
    let id: Int
    let avatarUrl: String
    let url: String
    let htmlUrl: String
    let type: String
    let isSiteAdmin: Bool
}

extension User {
    static func fromJson(_ json: AnyObject) -> User {
        let json = JSON(json)
        
        return User(login: json["login"].stringValue,
                    id: json["id"].intValue,
                    avatarUrl: json["avatar_url"].stringValue,
                    url: json["url"].stringValue,
                    htmlUrl: json["html_url"].stringValue,
                    type: json["type"].stringValue,
                    isSiteAdmin: json["site_admin"].boolValue)
    }
    
    static func fromJSONArray(_ json: [AnyObject]) -> [Repository] {
        return json.map { Repository.fromJSON($0) }
    }
    
    static func fromDict(_ dict: [String: JSON]) -> User {
        return User(login: dict["login"]!.stringValue,
                    id: dict["id"]!.intValue,
                    avatarUrl: dict["avatar_url"]!.stringValue,
                    url: dict["url"]!.stringValue,
                    htmlUrl: dict["html_url"]!.stringValue,
                    type: dict["type"]!.stringValue,
                    isSiteAdmin: dict["site_admin"]!.boolValue)
    }
}
