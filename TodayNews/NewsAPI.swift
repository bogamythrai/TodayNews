//
//  NewsAPI.swift
//  TodayNews
//
//  Created by Mythrai Boga on 29/03/25.
//

import Foundation

enum NewsAPI {
    static let apiKey = ""

    case topHeadlines
    case search(query: String)

    var urlString: String {
        switch self {
            case .topHeadlines:
                return "https://newsapi.org/v2/top-headlines?language=en&sources=the-hindu,the-times-of-india&apiKey=\(NewsAPI.apiKey)"
            case .search(let query):
                return "https://newsapi.org/v2/everything?language=en&q=\(query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")&apiKey=\(NewsAPI.apiKey)"
        }
    }

    var url: URL? {
        return URL(string: urlString)
    }
}
