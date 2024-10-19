//
//  RecipeRowView.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/19/24.
//

import SwiftUI

struct RecipeRowView: View {
    var recipe: Recipe
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: recipe.photoUrlSmall ?? "")) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                case .failure(_):
                    errorImage
                case .empty:
                    placeHolderImage
                @unknown default:
                    placeHolderImage
                }
            }
            .frame(width: 48, height: 48)
            Text(recipe.name)
        }
    }
    
    var placeHolderImage: some View {
        Image(systemName: "photo")
            .font(.title)
            .foregroundStyle(.placeholder)
    }
    
    @ViewBuilder
    var errorImage: some View {
        if #available(iOS 18, *) {
            // Show the new system two color photo with red (!) overlay
            Image(systemName: "photo.badge.exclamationmark")
                .font(.title)
                .foregroundStyle(.secondary)
                .symbolRenderingMode(.multicolor)
        } else {
            // Otherwise show the old "photo" image in red
            Image(systemName: "photo")
                .font(.title)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    VStack {
        RecipeRowView(recipe: Recipe(uuid: UUID(),
                                     cuisine: "British",
                                     name: "Bangers & Mash",
                                     photoUrlLarge: nil,
                                     photoUrlSmall: nil,
                                     sourceUrl: nil,
                                     videoUrl: nil))
        Spacer()
    }
}
