//
//  NewsRespositoryMock.swift
//  CleanSwiftWithRouterTests
//
//  Created by Kevin Vishal on 05/05/24.
//

import Foundation
import Combine
@testable import CleanSwiftWithRouter

struct NewsListRepoMock: NewsRespositoryProtocol {
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
        // return Future<[NewsEntity], NetworkError> { promise in
        //           Task {
        //                let newsListResult = await NetworkClient().requestWithAsyncType(withType: NewsList.self,  withEndpoint: NewsEndpoint())
        //                switch newsListResult {
        //                case .success(let newsList):
        //                    let newsListEntities = newsList.newsList?.compactMap { news in
        //                        news.toDomain()
        //                    }
        //                    return promise(.success(newsListEntities ?? []))
        //                case .failure(let error):
        //                    return promise(.failure(error))
        //                }
        //  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
        return Just([NewsEntity(author: "Kevin", title: "Title is balcnk", desciption: "A very long des", url: "http://alliswell.com", imageUrl: "http://alliswell.com/yuu.png")])
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
        //    }
        ///         }
        //  }
        // .eraseToAnyPublisher()
    }
}
