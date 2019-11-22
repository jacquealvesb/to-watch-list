//
//  SearchMovieViewViewModel.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 21/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import Combine

class SearchMovieViewViewModel {
    private let tmdbService: TMDBService
    
    @Published private(set) var movies: [Movie] = [Movie]()
    @Published private(set) var isFetching: Bool = false
    @Published private(set) var info: String? = nil

    var hasInfo: Bool {
        return info != nil
    }
    
    var numberOfMovies: Int {
        return movies.count
    }
    
    init(query: AnyPublisher<String?, Never>, tmdbService: TMDBService) {
        self.tmdbService = tmdbService
        
        _ = query // Listen to changes in query and search movie
            .throttle(for: 1.0, scheduler: RunLoop.main, latest: false)
            .removeDuplicates()
            .sink { [weak self] queryString in
                self?.searchMovie(query: queryString)
                
                if let queryString = queryString, queryString.isEmpty {
                    self?.movies = []
                    self?.info = "Start searching your favorite movies"
                }
            }
    }
    
    public func viewModelForMovie(at index: Int) -> MovieViewModel? {
        guard index < movies.count else {
            return nil
        }
        return MovieViewModel(movie: movies[index])
    }

    public func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else {
            self.movies = []
            self.info = "Start searching your favorite movies"
            return
        }

        self.movies = [] // Clears movies array
        self.isFetching = true // Set fetching to true
        self.info = nil

        self.tmdbService.searchMovie(query: query) { [weak self] (response, error) in
            self?.isFetching = false // Set fetching to false whrn receive completion

            if error != nil { // Check if any error occured
                self?.info = "Something wrong happend"
                return
            }

            guard let response = response, response.totalResults > 0 else { // Check if receive a response and if it is not empty
                self?.info = "No result for \(query)"
                return
            }

            self?.movies = Array(response.results.prefix(5)) // Set movies array to the first five results
        }
    }
}
