//
//  Person.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

//import Foundation

//struct Person: Codable {
//    let id: Int?
//    let knownFor: [KnownFor]
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case knownFor = "known_for"
//    }
//
//    // MARK: - KnownFor
//    struct KnownFor: Codable {
//        let title: String
//        let overview: String
//        let posterPath: String?
//
//        enum CodingKeys: String, CodingKey {
//            case title, overview
//            case posterPath = "poster_path"
//        }
//    }
//}
import Foundation

struct Person: Codable {
    let results: [Result]
    

    enum CodingKeys: String, CodingKey {
        case results
        
    }
}
// MARK: - Result
struct Result: Codable {
    
    let knownFor: [KnownFor]

    enum CodingKeys: String, CodingKey {

        case knownFor = "known_for"
    }
}

// MARK: - KnownFor
struct KnownFor: Codable {

    let title: String?
    let overview, posterPath: String?

    enum CodingKeys: String, CodingKey {

        case title
        case overview
        case posterPath = "poster_path"

    }
}




