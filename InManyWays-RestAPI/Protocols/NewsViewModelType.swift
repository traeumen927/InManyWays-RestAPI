//
//  viewModelType.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import Foundation
import RxSwift
import RxCocoa


protocol NewsViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: NewsViewModelInput { get }
    var output: NewsViewModelOutput { get }
}

protocol NewsViewModelInput {
    var loadData: AnyObserver<Void> { get set }
}

protocol NewsViewModelOutput {
    var items: PublishSubject<News> { get set }
}
