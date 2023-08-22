//
//  ViewModelType.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/22.
//

import Foundation

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var input: Input { get }
    var output: Output { get }
}
