//
//  Repository.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/24.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import Foundation
import SwiftyJSON

// https://developer.github.com/v3/repos/#list-all-public-repositories
struct Repository {
    let id: Int
    let name: String
    let fullName: String
    let description: String
    let isPrivate: Bool
    let isForked: Bool
    let url: String
    let htmlUrl: String
}

extension Repository {
    static func fromJSON(_ json: AnyObject) -> Repository {
        let json = JSON(json)
        
        return Repository(id: json["id"].intValue,
                          name: json["name"].stringValue,
                          fullName: json["full_name"].stringValue,
                          description: json["description"].stringValue,
                          isPrivate: json["private"].boolValue,
                          isForked: json["fork"].boolValue,
                          url: json["url"].stringValue,
                          htmlUrl: json["html_url"].stringValue)
    }
    
    static func fromJSONArray(_ json: [AnyObject]) -> [Repository] {
        return json.map { Repository.fromJSON($0) }
    }
}
