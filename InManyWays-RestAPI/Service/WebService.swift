//
//  WebService.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/16.
//

import Foundation

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

//class NewsService {
//    func load<T>(resource: Resource<T>, complition: @escaping (T?) -> ()) {
//        URLSession.shared.dataTask(with: resource.url) { data, response, error in
//            if let data = data {
//                DispatchQueue.main.async {
//                    complition(resource.parse(data))
//                }
//            } else {
//                complition(nil)
//            }
//        }
//    }
//}
