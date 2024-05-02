//
//  NewsListViewModel.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import Combine
import Foundation



enum NewListResultState {
    case none
    case loading
    case error(String)
    case results([NewsEntity])
}

final class NewsListViewModel: ObservableObject {
//    @Published var newsList: [NewsEntity] = []
//    @Published var isLoading: Bool = false
//    @Published var errorMessage = ""
    
    @Published var newListResultState: NewListResultState = .none
    
    let newsUsecase = NewsUsecase(newsRespository: NewsListRepoImp())
    private var cancellable: AnyCancellable?
    
    func fetcNews() {
        DispatchQueue.main.async { [weak self] in
            self?.newListResultState = .loading
        }
        cancellable = newsUsecase.newsRespository.fetchAllNews().sink { completion in
            //guard let error = completion.
            
            switch completion {
            case .finished:
                print("Completion \(completion)")
            case .failure(let networkError):
                self.newListResultState = .error(networkError.localizedDescription)
            }
        } receiveValue: { newsEntities in
            self.newListResultState = .results(newsEntities)
        }
    }
    
    deinit {
        cancellable?.cancel()
    }
}
