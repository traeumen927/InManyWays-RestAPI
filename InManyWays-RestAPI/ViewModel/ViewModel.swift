//
//  ViewModel.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/15.
//

import Foundation

class ViewModel {
    private let Ways: [Way] = Way.allCases
    
    func numberOfRows(_ section: Int) -> Int {
        return Ways.count
    }
    
    func WayAt(_ index: Int) -> Way {
        return Ways[index]
    }
}
