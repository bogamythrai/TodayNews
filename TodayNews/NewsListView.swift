//
//  NewsListView.swift
//  TodayNews
//
//  Created by Mythrai Boga on 13/03/25.
//

import SwiftUI

struct NewsListView: View {
    @StateObject private var viewModel = NewsViewModel()
    @Namespace private var animationNamespace
    @State private var isDetailViewActive = false

    var body: some View {
        NavigationView {
            // Add search bar here and filter articles based on search text
            ScrollView(showsIndicators: false) {
                HStack {
                    TextField("Search for News, Topics", text: $viewModel.searchText)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal, 8)
                }
                .padding(.top, 8)
                LazyVStack {
                    ForEach(viewModel.articles) { article in
                        NavigationLink {
                            NewsDetailView(article: article,
                                           namespace: animationNamespace,
                                           articles: viewModel.articles)
                        } label: {
                            NewsCardView(article: article,
                                         namespace: animationNamespace)
                        }
                    }
                }
                .refreshable {
                    // Fetch new data from api and update ui
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        viewModel.fetchNews()
                    }
                }
            }
            .refreshable(action: {
                viewModel.fetchNews()
            })
            // Navigation View add Title and a right bar button item
            .background(Color(.systemBackground))
            .padding(.horizontal, 8)
            .navigationTitle("Top News")
        }
    }
}

#Preview {
    NewsListView()
}
