//
//  SearchMovieViewViewModel.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 21/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class SearchMovieViewViewModel {
    private let tmdbService: TMDBService
    private let disposeBag = DisposeBag()
    
    private let _movies = BehaviorRelay<[Movie]>(value: [])
    private let _isFetching = BehaviorRelay<Bool>(value: false)
    private let _info = BehaviorRelay<String?>(value: nil)
    
    var isFetching: Driver<Bool> {
        return _isFetching.asDriver()
    }
    
    var movies: Driver<[Movie]> {
        return _movies.asDriver()
    }
    
    var info: Driver<String?> {
        return _info.asDriver()
    }
    
    var hasInfo: Bool {
        return _info.value != nil
    }
    
    var numberOfMovies: Int {
        return _movies.value.count
    }
    
    init(query: Driver<String>, tmdbService: TMDBService) {
        self.tmdbService = tmdbService
        
        // Observe changes in query string
        query
            .throttle(RxTimeInterval.seconds(1)) // Limit stream in 1s
            .distinctUntilChanged() // Only make request when change value
            .drive(onNext: { [weak self] queryString in // When query string changes
                self?.searchMovie(query: queryString) // Search movie
                
                if queryString.isEmpty {
                    self?._movies.accept([])
                    self?._info.accept("Start searching your favorite movies")
                }
            }).disposed(by: disposeBag)
    }
    
    public func viewModelForMovie(at index: Int) -> MovieViewModel? {
        guard index < _movies.value.count else {
            return nil
        }
        return MovieViewModel(movie: _movies.value[index])
    }
    
    private func searchMovie(query: String?) {
        guard let query = query, !query.isEmpty else {
            return
        }
        
        self._movies.accept([]) // Clears movies array
        self._isFetching.accept(true) // Set fetching to true
        self._info.accept(nil)
        
        self.tmdbService.searchMovie(query: query) { [weak self] (response, error) in
            self?._isFetching.accept(false) // Set fetching to false whrn receive completion
            
            if let error = error { // Check if any error occured
                self?._info.accept(error.localizedDescription)
                return
            }
            
            guard let response = response, response.totalResults > 0 else { // Check if receive a response and if it is not empty
                self?._info.accept("No result for \(query)")
                return
            }
            
            self?._movies.accept(Array(response.results.prefix(5))) // Set movies array to the first five results
        }
    }
}
