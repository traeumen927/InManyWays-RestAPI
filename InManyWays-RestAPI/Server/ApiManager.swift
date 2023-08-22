//
//  ApiManager.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/16.
//

import Foundation
import RxSwift
import Alamofire

struct ApiManager {
    
    static let shared = ApiManager()
    
    let key = "5751ab390d944400bfe22050e8f954c6"
    
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
}
