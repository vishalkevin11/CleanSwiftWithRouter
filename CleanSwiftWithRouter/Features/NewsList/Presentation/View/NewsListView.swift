//
//  NewsListView.swift
//  CleanSwiftWithRouter
//
//  Created by kevin.saldanha on 30/04/24.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var newsListViewModel = NewsListViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(newsListViewModel.newsList, id: \.id) { newEntity in
                    Text(newEntity.title ?? "--")
                }
            }
        }
        .task {
            newsListViewModel.fetcNews()
        }
    }
}

#Preview {
    NewsListView()
}
