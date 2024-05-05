//
//  NewsListView.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var newsListViewModel = NewsListViewModel(newsUsecase: NewsUsecase(newsRespository: NewsListRepoImp()))
    
//    init(newsListViewModel: NewsListViewModel) {
//        _newsListViewModel = StateObject(wrappedValue: newsListViewModel)
//    }
//    
    var body: some View {
        NavigationStack {
            ZStack {
                switch newsListViewModel.newListResultState {
                case .loading:
                    ProgressView()
                case .error(let message):
                    Text(message)
                        .foregroundStyle(.red)
                case .results(let newsList ):
                    List {
                        ForEach(newsList, id: \.id) { newEntity in
                            Text(newEntity.title ?? "--")
                        }
                    }
                case .none:
                    Text("Welcome !")
                }
            }
        }
//        .task {
//            newsListViewModel.fetcNews()
//        }
    }
}

#Preview {
    NewsListView()
}
