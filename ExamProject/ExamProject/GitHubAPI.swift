//
//  GitHubAPI.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/24.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Timepiece

let GitHubAPIProvider = RxMoyaProvider<GitHubAPI>()

public enum GitHubAPI {
    case trendingRepos
}

extension GitHubAPI: TargetType {
    public var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    public var path: String {
        switch self {
        case .trendingRepos:
            return "/search/repositories"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .trendingRepos:
            return .get
        }
    }
    
    public var parameters: [String : Any]? {
        let lastWeek = Date() - 1.week
        
        return ["q": "created:>" + lastWeek!.toString(format: "yyyy-MM-dd"),
                "sort": "stars",
                "order": "desc"
        ]
    }
    
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    public var sampleData: Data {
        switch self {
        case .trendingRepos:
            return "[]".data(using: String.Encoding.utf8)!
        }
    }
    
    public var task: Task {
        return .request
    }
}
