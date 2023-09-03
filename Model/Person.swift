//
//  Person.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import Foundation


struct Person: Codable {
    let results: [Result]
}


struct Result: Codable {
    let knownFor: [KnownFor]
}

// MARK: - KnownFor
struct KnownFor: Codable {
    let title: String
    let overview: String
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case title, overview
        case posterPath = "poster_path"
    }
}
