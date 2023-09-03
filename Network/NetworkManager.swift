//
//  NetworkManager.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import Foundation
import Alamofire


func TrendAPIAllCallRequest(type: String? = nil, completion: @escaping ([TrendingItem]?) -> Void) {
    
    var url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIKey.TMDBKey)"
    if let type = type { url = "https://api.themoviedb.org/3/trending/\(type)/day?api_key=\(APIKey.TMDBKey)&size=5&page=3"}

    AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: TrendingResponse.self) { response in
        guard let value = response.value else { return }
        
        if let statusCode = response.response?.statusCode {
                    print("Status Code: \(statusCode)")
                }
        
        
        switch response.result {
        case .success(let value):
            completion(value.results)
            print(value)
            
        case .failure(let error):
            print("Error: \(error)")
            completion(nil)
        }
    }
}


func TrendAPIPersonCallRequest(type: String? = nil, completion: @escaping ([Result]?) -> Void) {
    
    var url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIKey.TMDBKey)"
    if let type = type { url = "https://api.themoviedb.org/3/trending/\(type)/day?api_key=\(APIKey.TMDBKey)&size=5&page=3"}

    AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: Person.self) { response in
        guard let value = response.value else { return }
        
        if let statusCode = response.response?.statusCode {
                    print("Status Code: \(statusCode)")
                }
        
        
        switch response.result {
        case .success(let value):
            completion(value.results)
            print(value)
            
        case .failure(let error):
            print("Error: \(error)")
            completion(nil)
        }
    }
}
        
