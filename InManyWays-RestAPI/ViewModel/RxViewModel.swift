//
//  RxViewModel.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import Foundation
import RxSwift
import RxCocoa

class RxViewModel {
    
    struct Input {
        let loadData: AnyObserver<Void>
    }
    
    struct Output {
        let items = PublishSubject<News>()
    }
    
    var input: RxViewModel.Input
    var output: RxViewModel.Output
    
    private let service: NewsService
    private let disposeBag = DisposeBag()
    
    init() {
        let loadDataSubject = PublishSubject<Void>()
        
        self.input = Input(loadData: loadDataSubject.asObserver())
        self.output = Output()
    
        self.service = NewsService.shared
        
        loadDataSubject
            .flatMap({ self.service.getNews() })
            .bind(to: self.output.items)
            .disposed(by: disposeBag)
    }
}
