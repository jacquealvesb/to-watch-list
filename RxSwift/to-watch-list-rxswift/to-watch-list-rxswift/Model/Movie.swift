//
//  Movie.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

public struct MoviesResponse: Codable {
    public let page: Int
    public let totalResults: Int
    public let totalPages: Int
    public let results: [Movie]
}

public struct Movie: Codable {
    
    public let id: Int
    public let title: String
    public let overview: String
    public let releaseDate: Date
    public let posterPath: String?
    public let status: MovieStatus = .none
    public let review: String? = nil
    public let watchedDate: Date? = nil
    public let rating: Int? = nil
    public var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}

public enum MovieStatus: Int, Codable {
    case toWatch
    case watched
    case none
}
