//
//  NewsUsecase.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//


import Combine
import Foundation


struct NewsUsecase {
    
    let newsRespository: NewsRespositoryProtocol
    
    init(newsRespository: NewsRespositoryProtocol) {
        self.newsRespository = newsRespository
    }
    
    func getAllNews() -> AnyPublisher<[NewsEntity], NetworkError> {
      return newsRespository.fetchAllNews()
    }
  
}
