//
//  News.swift
//  InManyWays-RestAPI
//
//  Created by 홍정연 on 2023/08/16.
//

import Foundation

struct News: Codable {
    let status: String
    let totalResults: Int
    let articles: [article]
}

struct article: Codable {
    let author: String?
    let title: String
    let description: String
    let url: URL?
    let urlToImage: URL?
    let publishedAt: String
    let content: String
}
