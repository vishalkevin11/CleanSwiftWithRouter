//
//  BaseEndpoint.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Foundation

public enum RequestType: String {
    case GET
    case POST
}

typealias HTTPCode = Int
enum NetworkError: Error {
    case errorFrom(Error)
    case notFound
    case badRequest
    case invalidRequest
    case httpCode(HTTPCode)
    case responseUnsuccessful
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case let .errorFrom(error): return "Error is \(error.localizedDescription)"
        case .notFound: return "The requested url was not found"
        case .badRequest: return "Bad Request"
        case .invalidRequest: return "Invalid Request"
        case let .httpCode(code): return "Unexpected HTTP code: \(code)"
        case .responseUnsuccessful: return "Response Unsuccessful"
        }
    }
}

protocol BaseEndpoint {
    
    var path: String? { get }
    var type: RequestType { get}
    var body: [String : Any]? { get }
    var headers: [String : Any]? { get }
}

extension BaseEndpoint {
    
    private var getUrl: URL? {
        guard let path = path else {
            return nil
        }
        return URL(string: path)
    }
    
    func urlRequest() throws -> URLRequest {
        guard let url = getUrl else {
            throw NetworkError.invalidRequest
        }
        var request =  URLRequest(url:url)
        request.httpMethod = type.rawValue
        request.httpBody =  body != nil ? try?  JSONSerialization.data(withJSONObject: body!) : nil
        return request
    }
}
