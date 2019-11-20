//
//  MovieDetailsViewModel.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 20/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    let movie: Movie
    
    var movieViewModel: MovieViewModel {
        return MovieViewModel(movie: self.movie)
    }
    
    var title: String {
        return movie.name
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
