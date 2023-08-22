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
}
