//
//  NewsRespositoryProtocol.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation

protocol NewsRespositoryProtocol {
    func fetchAllNews() -> AnyPublisher<[NewsEntity], NetworkError>
}
