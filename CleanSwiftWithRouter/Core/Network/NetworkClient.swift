//
//  HttpClient.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation


class NetworkClient {
    // With combine
    func request<T: Decodable>(withType: T.Type, withEndpoint: BaseEndpoint) ->  AnyPublisher<T, NetworkError> {
        do {
            let request = try  withEndpoint.urlRequest()
            return URLSession.shared.dataTaskPublisher(for: request)
                .mapError { NetworkError.errorFrom($0)}
                .tryMap {$0.data}
                .decode(type: T.self, decoder: JSONDecoder())
                .mapError { _ in return NetworkError.responseUnsuccessful }
                .receive(on:RunLoop.main)
                .eraseToAnyPublisher()
        } catch {
            return Fail(error: NetworkError.badRequest).eraseToAnyPublisher()
        }
    }

    // with async/ await
    func requestWithAsyncType<T: Decodable>(withType: T.Type, withEndpoint: BaseEndpoint) async ->  Result<T, NetworkError> {
        do {
            let request = try  withEndpoint.urlRequest()
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let status = (response as? HTTPURLResponse)?.statusCode, (200 ..< 400).contains(status) else {
                return .failure(.badRequest)
            }
            guard let jsonData = try? JSONDecoder().decode(T.self, from: data) else {
                return .failure(.responseUnsuccessful)
            }
            return .success(jsonData)
        } catch {
            return .failure( NetworkError.invalidRequest)
        }
    }
    
}
