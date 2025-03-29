//
//  NewsDetailView.swift
//  TodayNews
//
//  Created by Mythrai Boga on 13/03/25.
//

import Foundation
import SwiftUI

struct NewsDetailView: View {
    @State var article: Article
    var namespace: Namespace.ID
    let articles: [Article]

    var body: some View {
        VStack(alignment: .leading) {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { phase in
                    if let image = phase.image {
                        image.resizable()
                            .matchedGeometryEffect(id: "image\(article.id)", in: namespace)
                            .scaledToFit()
                    } else {
                        Color.gray.frame(height: 300)
                    }
                }
            }

            Text(article.title)
                .matchedGeometryEffect(id: "title\(article.id)", in: namespace)
                .font(.headline)
                .padding()

            Text(article.description ?? "")
                .padding()

            Spacer()

            HStack {
                Button(action: { /* Like action */ }) {
                    Image(systemName: "heart")
                        .foregroundColor(.red)
                        .padding()
                }

                Button(action: { /* Bookmark action */ }) {
                    Image(systemName: "bookmark")
                        .foregroundColor(.blue)
                        .padding()
                }

                Spacer()

                Button(action: { /* Share action */ }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.green)
                        .padding()
                }
            }
            .padding()
        }
        .background(Color(.systemBackground))
        .gesture(
            DragGesture().onEnded { value in
                if let currentIndex = articles.firstIndex(where: { $0.id == article.id }) {
                    if value.translation.height < -50, currentIndex < articles.count - 1 {
                        withAnimation(.linear) {
                            self.article = articles[currentIndex + 1]
                        }
                    } else if value.translation.height > 50, currentIndex > 0 {
                        withAnimation(.easeInOut) {
                            self.article = articles[currentIndex - 1]
                        }
                    }
                }
            }
        )
    }
}
