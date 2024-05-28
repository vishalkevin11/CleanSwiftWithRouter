//
//  NewsListRepoImp.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation

struct NewsListRepoImp: NewsRespositoryProtocol {
    //    func fetchAllNews() -> AnyPublisher<[NewsEntity], NetworkError> {
    //        return NetworkClient().request(withType: NewsList.self,  withEndpoint: NewsEndpoint())
    //            .compactMap { newsList in
    //                newsList.newsList?.compactMap {news in
    //                    news.toDomain()
    //                }
    //            }
    //            .eraseToAnyPublisher()
    //    }
    //
    // Async awair
    func fetchAllNews() -> AnyPublisher<[NewsEntity], NetworkError> {
        return Future<[NewsEntity], NetworkError> { promise in
            Task {
                let newsListResult = await NetworkClient().requestWithAsyncType(withType: NewsList.self,  withEndpoint: NewsEndpoint())
                switch newsListResult {
                case .success(let newsList):
                    let newsListEntities = newsList.newsList?.compactMap { news in
                        news.toDomain()
                    }
                    return promise(.success(newsListEntities ?? []))
                case .failure(let error):
                    return promise(.failure(error))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}



