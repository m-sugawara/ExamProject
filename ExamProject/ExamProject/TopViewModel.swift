//
//  TopViewModel.swift
//  ExamProject
//
//  Created by M_Sugawara on 2017/06/24.
//  Copyright © 2017年 Sugawar. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya

class TopViewModel {
    private let provider: RxMoyaProvider<GitHubAPI>
    
    var buttonTaps = PublishSubject<Void>()
    
    let results: Observable<[Repository]>
    var simpleTimer: Observable<Int>
    
    let disposeBag = DisposeBag()
    
    init(provider: RxMoyaProvider<GitHubAPI>) {
        self.provider = provider
        
        results = buttonTaps
            .asObservable()
            .flatMapLatest{
                provider.request(.trendingRepos)
                .retry(3)
                .observeOn(MainScheduler.instance)
            }
            .mapJSON()
            .map({ (json) in
                let dict = json as? [String: AnyObject]
                if let items = dict?["items"] as? [AnyObject] {
                    return Repository.fromJSONArray(items)
                } else {
                    return []
                }
            })
        
        simpleTimer = Observable<Int>.interval(1.0, scheduler: MainScheduler.instance)
        
    }
}
