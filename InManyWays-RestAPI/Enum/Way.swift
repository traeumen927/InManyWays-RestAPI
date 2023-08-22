//
//  Way.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import Foundation

enum Way: String, CaseIterable {
    case UrlSession
    case Alamofire
    case RxSwift
    case Moya
}

extension Way {
    var description: String {
        get {
            switch (self) {
            case .UrlSession:
                return "UrlSession"
            case .Alamofire:
                return "Alamofire"
            case .RxSwift:
                return "RxSwift"
            case .Moya:
                return "Moya"
            }
        }
    }
}
