//
//  NewsCardView.swift
//  TodayNews
//
//  Created by Mythrai Boga on 13/03/25.
//

import SwiftUI

struct NewsCardView: View {
    let article: Article
    var namespace: Namespace.ID

    var body: some View {
        VStack {
            if let imageUrl = article.urlToImage, let url = URL(string: imageUrl) {
                AsyncImage(url: url) { image in
                    image.resizable().scaledToFill()
                } placeholder: {
                    Image("placeholder")
                        .resizable()
                        .scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: 250)
                        .clipped()
                }
                .frame(maxWidth: .infinity, maxHeight: 250)
                .clipped()
            }

            Text(article.title)
                .lineLimit(2)
                .matchedGeometryEffect(id: "title\(article.id)", in: namespace)
                .font(.headline)
                .foregroundStyle(.black)
                .padding(.all, 8)
        }
        .background(Color.white)
        .cornerRadius(16)
        .shadow(radius: 5)
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

// Create a preview for the NewsCardView
struct NewsCardView_Previews: PreviewProvider {
    static var previews: some View {
        NewsCardView(article: Article.example, namespace: Namespace().wrappedValue)
            .previewLayout(.sizeThatFits)
    }
}

// Create a sample Article for the preview
extension Article {
    static let example = Article(title: """
                                    Title Title Title Title Title Title Title Title Title  abc Title Title Title Title Title Title Title Title Title 
                                    """,
                                    description: "Description",
                                    urlToImage: "https://via.placeholder.com/150",
                                    url: "https://www.example.com")
    }
