//
//  NewsViewModel.swift
//  TodayNews
//
//  Created by Mythrai Boga on 13/03/25.
//

import Combine
import SwiftUI

class NewsViewModel: ObservableObject {
    private let networkService: NetworkService
    private var cancellables = Set<AnyCancellable>()

    @Published var articles: [Article] = []
    @Published var searchText: String = ""

    init(networkService: NetworkService = NetworkServiceImpl()) {
        self.networkService = networkService
        fetchNews()
        startListening()
    }

    private func startListening() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] searchText in
                guard let self = self, !searchText.isEmpty else { return }
                self.fetchNews(for: searchText)
            }
            .store(in: &cancellables)
    }

    func fetchNews() {
        if searchText.isEmpty {
            fetchTopNews()
        } else {
            fetchNews(for: searchText)
        }
    }

    func fetchNews(for query: String) {
        networkService.fetchData(from: .search(query: query))
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (response: NewsResponse) in
                self?.articles = response.articles
            })
            .store(in: &cancellables)
    }

    func fetchTopNews() {
        networkService.fetchData(from: .topHeadlines)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] (response: NewsResponse) in
                self?.articles = response.articles
            })
            .store(in: &cancellables)
    }
}
