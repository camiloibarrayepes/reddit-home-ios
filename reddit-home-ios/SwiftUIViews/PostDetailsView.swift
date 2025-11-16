//
//  PostDetailsView.swift
//  reddit-home-ios
//
//  Created by Camilo Ibarra yepes on 16/11/25.
//

import SwiftUI

struct PostDetailsView: View {

    let post: PostModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                // Imagen (si existe)
                if let url = post.imageURL {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(maxWidth: .infinity, minHeight: 200)

                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(12)

                        case .failure(_):
                            Color.gray.opacity(0.3)
                                .frame(height: 200)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.largeTitle)
                                        .foregroundColor(.white)
                                )

                        @unknown default:
                            EmptyView()
                        }
                    }
                }

                // Título
                Text(post.title)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.primary)

                // Upvotes & comentarios
                HStack(spacing: 16) {
                    Label("\(post.upvotes)", systemImage: "arrow.up.circle.fill")
                        .foregroundColor(.orange)

                    Label("\(post.comments)", systemImage: "text.bubble.fill")
                        .foregroundColor(.blue)
                }
                .font(.subheadline)

                // Cuerpo del post
                if !post.body.isEmpty {
                    Text(post.body)
                        .font(.body)
                        .foregroundColor(.secondary)
                        .padding(.top, 8)
                }

                Spacer(minLength: 20)
            }
            .padding()
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Preview

struct PostDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        PostDetailsView(
            post: PostModel(
                id: "123",
                title: "Ejemplo de título de un post de Reddit",
                upvotes: 1200,
                comments: 340,
                body: "Este es un ejemplo de cuerpo de texto para un post",
                imageURL: URL(string: "https://picsum.photos/500")
            )
        )
    }
}
