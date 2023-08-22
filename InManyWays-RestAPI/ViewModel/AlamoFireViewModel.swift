//
//  AlamoFireViewModel.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import Foundation
import RxSwift
import RxCocoa

class AlamoFireViewModel: NewsViewModelType {
    
    
    
    struct Input: NewsViewModelInput {
        var loadData: AnyObserver<Void>
    }
    
    struct Output: NewsViewModelOutput {
        var items = PublishSubject<News>()
    }
    
    var input: NewsViewModelInput
    
    var output: NewsViewModelOutput
    
    private let service: NewsService
    private let disposeBag = DisposeBag()
    
    init(service: NewsService = NewsService.shared) {
        let loadDataSubject = PublishSubject<Void>()
        
        self.input = Input(loadData: loadDataSubject.asObserver())
        self.output = Output()
        
        self.service = service
        
        loadDataSubject
            .flatMap({ self.service.getNews() })
            .bind(to: self.output.items)
            .disposed(by: disposeBag)
    }
}
