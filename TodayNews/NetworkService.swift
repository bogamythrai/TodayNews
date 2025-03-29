//
//  NetworkService.swift
//  TodayNews
//
//  Created by Mythrai Boga on 29/03/25.
//

import Combine
import Foundation

protocol NetworkService {
    func fetchData<T: Decodable>(from api: NewsAPI) -> AnyPublisher<T, Error>
}

class NetworkServiceImpl: NetworkService {
    func fetchData<T: Decodable>(from api: NewsAPI) -> AnyPublisher<T, Error> {
        guard let url = api.url else {
            return Fail(error: URLError(.badURL))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
