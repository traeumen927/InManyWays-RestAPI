//
//  Server.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/16.
//

import Foundation

struct Server {
    static func url() -> URL {
        return URL(string: "https://newsapi.org/v2/everything?q=apple&from=2023-08-15&to=2023-08-15&sortBy=popularity&apiKey=\(ApiManager.shared.key)")!
    }
}
