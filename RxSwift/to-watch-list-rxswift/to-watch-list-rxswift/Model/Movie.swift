//
//  Movie.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

struct Movie {
    var poster: Data?
    var name: String
    var overview: String
    var releaseDate: Date
    var status: MovieStatus
    var review: String?
    var watchedDate: Date?
    var rating: Int?
    
    init(poster: Data?, name: String, overview: String, releaseDate: Date, status: MovieStatus, review: String? = nil, watchedDate: Date? = nil, rating: Int? = nil) {
        self.poster = poster
        self.name = name
        self.overview = overview
        self.releaseDate = releaseDate
        self.status = status
        self.review = review
        self.watchedDate = watchedDate
        self.rating = rating
    }
}
