//
//  NewsService.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/20.
//

import Foundation
import RxSwift

class NewsService {
    static let shared = NewsService()
    
    private init() {}
    
    func getNews() -> Single<News> {
        return ApiManager.shared.request(path: Server.url())
    }
}
