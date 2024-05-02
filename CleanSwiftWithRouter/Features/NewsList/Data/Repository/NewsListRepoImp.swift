//
//  NewsListRepoImp.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation

struct NewsListRepoImp: NewsRespositoryProtocol {
    func fetchAllNews() -> AnyPublisher<[NewsEntity], NetworkError> {
        return NetworkClient().request(withType: NewsList.self,  withEndpoint: NewsEndpoint())
            .compactMap { newsList in
                newsList.newsList?.compactMap {news in
                    news.toDomain()
                }
            }
            .eraseToAnyPublisher()
    }
}
