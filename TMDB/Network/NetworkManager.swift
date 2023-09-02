//
//  NetworkManager.swift
//  TMDB
//
//  Created by 이승현 on 2023/09/03.
//

import Foundation
import Alamofire


func TrendAPICallRequest() {
    let url = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIKey.TMDBKey)"
    AF.request(url, method: .get).validate(statusCode: 200...500).responseDecodable(of: TrendingItem.self) { response in
        guard let value = response.value else { return }
        
        if let statusCode = response.response?.statusCode {
                    print("Status Code: \(statusCode)")
                }
        
        
        switch response.result {
        case .success(let value):
            
            
            print(value)
            
        case .failure(let error):
            print("Error: \(error)")
        }
    }
}
        
