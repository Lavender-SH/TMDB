//
//  NetworkManager.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import Foundation
import Alamofire

// MARK: - All
func TrendAPIAllCallRequest(type: String? = nil, page: Int, completion: @escaping ([TrendingItem]?) -> Void) {
    
    var url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIKey.TMDBKey)"
    //if let type = type { "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIKey.TMDBKey)" }
    if let type = type { url = "https://api.themoviedb.org/3/trending/\(type)/day?api_key=\(APIKey.TMDBKey)&size=5&page=\(page)"}

    AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: TrendingResponse.self) { response in
        guard let value = response.value else { return }
        
        if let statusCode = response.response?.statusCode {
                    //print("===000===Status Code: \(statusCode)")
                }
        
        
        switch response.result {
        case .success(let value):
            completion(value.results)
            //print(value)
            
        case .failure(let error):
            print("Error: \(error)")
            completion(nil)
        }
    }
}

// MARK: - person
//⭐️⭐️⭐️
func TrendAPIPersonCallRequest(type: String? = nil, page: Int, completion: @escaping ([Result]?) -> Void) {
    
    var url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIKey.TMDBKey)"
    if let type = type { url = "https://api.themoviedb.org/3/trending/\(type)/day?api_key=\(APIKey.TMDBKey)&size=5&page=\(page)"}

    print(url)
    AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: Person.self) { response in
        
//        print(String(describing: response))
        
        //print("===555===", response.value)
        //print("===1111===", response.response?.statusCode)
        guard let value = response.value else { return }
            
        if let statusCode = response.response?.statusCode {
                    //print("===1111===Status Code: \(statusCode)")
                }
        
        
        switch response.result {
        case .success(let value):
            completion(value.results)

            //print(value)
            
        case .failure(let error):
            print("Error: \(error)")
            completion(nil)
        }
    }
}
        
