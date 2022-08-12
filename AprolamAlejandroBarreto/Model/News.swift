//
//  News.swift
//  AprolamAlejandroBarreto
//
//  Created by Alejandro Barreto on 10/08/22.
//

import Foundation

struct News: Codable {
    let title: String
    let description: String
    let content: String
    let url: String
    let image: String
    let publishedAt: String
    let source: Source
}

struct Article: Codable {
    let totalArticles: Int
    let articles: [News]
}

struct Source: Codable {
    let name: String
    let url: String
}
