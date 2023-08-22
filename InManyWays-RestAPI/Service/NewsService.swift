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
    
    func getNews(type: Way) -> Single<News> {
        switch type {
        
        case .UrlSession:
            return ApiManager.shared.requestAF(path: Server.url())
            
        case .Alamofire:
            return ApiManager.shared.requestAF(path: Server.url())
        
        case .RxSwift:
            return ApiManager.shared.requestAF(path: Server.url())
        }
    }
}
