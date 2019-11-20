//
//  MovieCellViewModel.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieViewModel {
    private var movie: Movie
    
    private static let dateFormatter: DateFormatter = {
        $0.dateStyle = .medium
        $0.timeStyle = .none
        return $0
    }(DateFormatter())
    
    var poster: Data? {
        return movie.poster
    }
    
    var name: String {
        return movie.name
    }
    
    var overview: String {
        return movie.overview
    }
    
    var releaseDate: String {
        return MovieViewModel.dateFormatter.string(from: movie.releaseDate)
    }
    
    var review: String {
        return movie.review ?? ""
    }
    
    var watchedDate: String {
        guard let watchedDate = movie.watchedDate else { return "" }
        return "Watched on " + MovieViewModel.dateFormatter.string(from: watchedDate)
    }
    
    var rating: String {
        guard let rating = movie.rating else { return "" }
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            return acc + "⭐️"
        }
        return ratingText
    }
    
    var watched: Bool {
        return movie.status == .watched
    }
    
    var wantToWatch: Bool {
        return movie.status == .toWatch
    }
    
    init(movie: Movie) {
        self.movie = movie
    }
}
