//
//  DetailViewModel.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/22.
//

import Foundation
import RxSwift
import RxCocoa

class DetailViewModel: ViewModelType {
    var input: Input
    
    var output: Output
    
    struct Input {
        
    }
    
    struct Output {
        var item: BehaviorSubject<article>
    }
    
    init(article: article) {
        self.input = Input()
        self.output = Output(item: BehaviorSubject(value: article))
    }
}
