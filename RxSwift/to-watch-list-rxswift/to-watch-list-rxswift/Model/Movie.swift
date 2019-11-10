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
}
