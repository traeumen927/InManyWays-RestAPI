//
//  ApiManager.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/16.
//

import Foundation
import RxSwift
import Alamofire
import Moya

struct ApiManager {
    
    static let shared = ApiManager()
    
    // MARK: News API Key
    let key = "5751ab390d944400bfe22050e8f954c6"
    
    // MARK: for Moya
    private let provider = MoyaProvider<API>()
    
    // MARK: request by UrlSession
    func requestUS<T: Codable>(path: URL) -> Single<T> {
        return Single.create { single in
            let task = URLSession.shared.dataTask(with: path) { data, response, error in
                if let error = error {
                    single(.failure(error))
                    return
                }
                
                guard let data = data else {
                    single(.failure(NSError(domain: "APIError", code: -1, userInfo: nil)))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(T.self, from: data)
                    single(.success(result))
                } catch {
                    single(.failure(error))
                }
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    
    // MARK: request by Alamofire
    func requestAF<T: Codable>(path: URL) -> Single<T> {
        return Single<T>.create { single -> Disposable in
            AF.request(path).responseData { response in
                switch response.result {
                case .success(let resultData):
                    do {
                        let decodedJson = try JSONDecoder().decode(T.self, from: resultData)
                        single(.success(decodedJson))
                    } catch let error {
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return Disposables.create { }
        }
    }
    
    
    // MARK: request by UrlSession + Rx
    func requestRx<T: Codable>(path: URL) -> Single<T> {
        return Observable.just(path)
                    .flatMap { url -> Observable<Data> in
                        return URLSession.shared.rx.data(request: URLRequest(url: url))
                    }
                    .flatMap { data -> Observable<T> in
                        do {
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: data)
                            return Observable.just(result)
                        } catch {
                            return Observable.error(error)
                        }
                    }
                    .asSingle()
    }
    
    
    // MARK: request Moya
    func requestMoya() -> Single<News> {
        return provider.rx.request(.fetchNews)
                    .map(News.self)
    }
}


// MARK: - Place for Moya Library

enum API {
    case fetchNews
}

extension API: TargetType {
    var baseURL: URL {
        return URL(string: "https://newsapi.org/v2")!
    }

    var path: String {
        switch self {
        case .fetchNews:
            return "/everything"
        }
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        let parameters: [String: Any] = [
            "q": "apple",
            "from": "2023-08-15",
            "to": "2023-08-15",
            "sortBy": "popularity",
            "apiKey": ApiManager.shared.key
        ]
        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var headers: [String: String]? {
        return nil
    }
}
