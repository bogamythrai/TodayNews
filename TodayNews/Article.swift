//
//  Article.swift
//  TodayNews
//
//  Created by Mythrai Boga on 26/03/25.
//

import Foundation

struct Article: Codable, Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let urlToImage: String?
    let url: String

    enum CodingKeys: String, CodingKey {
        case title, description, urlToImage, url
    }
}
