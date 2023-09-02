//
//  Model.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import Foundation

struct TrendingResponse: Codable {
    let results: [TrendingItem]
}

struct TrendingItem: Codable {
    let id: Int
    let name: String? // for tv and person
    let title: String? // for movie
    let overview: String?
    let posterPath: String?
    let mediaType: MediaType

    enum CodingKeys: String, CodingKey {
        case id, name, title, overview
        case posterPath = "poster_path"
        case mediaType = "media_type"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
    case tv = "tv"
    case person = "person"
}
