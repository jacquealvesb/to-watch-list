//
//  MovieListViewModel.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 20/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieListViewModel {
    var movies: [Movie] = []
    
    var toWatchMovies: [Movie] {
        return movies.filter { $0.status == .toWatch }
    }
    
    var watchedMovies: [Movie] {
        return movies.filter { $0.status == .watched }
    }
    
    init() {
        movies = [
            Movie(poster: nil, name: "The Godfather", overview: "Um filme sobre isso e isso", releaseDate: Date(), status: .toWatch),
            Movie(poster: nil, name: "The Godmother", overview: "Um filme sobre isso e isso", releaseDate: Date(), status: .watched, review: "Gostei pacas", watchedDate: Date(), rating: 4)
        ]
    }
}
