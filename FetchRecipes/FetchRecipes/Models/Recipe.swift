//
//  Recipe.swift
//  FetchRecipes
//
//  Created by Oren Leavitt on 10/7/24.
//

import Foundation

struct Recipe: Codable {
    let uuid: UUID
    let cuisine: String
    let name: String
    let photoUrlLarge: String?
    let photoUrlSmall: String?
    let sourceUrl: String?
    let videoUrl: String?

    enum CodingKeys: String, CodingKey {
        case photoUrlLarge = "photo_url_large"
        case photoUrlSmall = "photo_url_small"
        case sourceUrl = "source_url"
        case videoUrl = "youtube_url"
        case uuid, cuisine, name
    }
}
