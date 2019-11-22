//
//  TMDBService.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 21/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

public enum TMDBError: Error {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError
}

class TMDBService {
    static var shared = TMDBService()
    
    private let baseAPIURL = "https://api.themoviedb.org/3"
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    func searchMovie(query: String, params: [String: String]? = nil, completionHandler: @escaping (_ response: MoviesResponse?, _ error: Error?) -> Void) {
        guard var urlComponents = URLComponents(string: "\(baseAPIURL)/search/movie") else {
            completionHandler(nil, TMDBError.invalidEndpoint)
            return
        }
        
        var queryItems = [ URLQueryItem(name: "api_key", value: TMDBApiKey),
                           URLQueryItem(name: "language", value: "en-US"),
                           URLQueryItem(name: "include_adult", value: "false"),
                           URLQueryItem(name: "region", value: "US"),
                           URLQueryItem(name: "query", value: query)
                        ]
        if let params = params {
            queryItems.append(contentsOf: params.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let url = urlComponents.url else {
            completionHandler(nil, TMDBError.invalidEndpoint)
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                completionHandler(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completionHandler(nil, TMDBError.invalidResponse)
                return
            }
            
            guard let data = data else {
                completionHandler(nil, TMDBError.noData)
                return
            }
            
            do {
                let moviesResponse = try self.jsonDecoder.decode(MoviesResponse.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(moviesResponse, nil)
                }
                
            } catch {
                completionHandler(nil, TMDBError.serializationError)
            }
            
        }.resume()
    }
}
