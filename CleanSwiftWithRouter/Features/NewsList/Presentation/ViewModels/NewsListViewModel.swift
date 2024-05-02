//
//  NewsListViewModel.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation


class NewsListViewModel: ObservableObject {
    @Published var newsList: [NewsEntity] = []
    let newsUsecase = NewsUsecase(newsRespository: NewsListRepoImp())
    private var cancellable: AnyCancellable?
    
    func fetcNews() {
      cancellable = newsUsecase.newsRespository.fetchAllNews().sink { completion in
            //guard let error = completion.
            print("Completion \(completion)")
        } receiveValue: { newsEntities in
            self.newsList = newsEntities
        }
        
    }
    
    deinit {
        cancellable?.cancel()
    }
}
