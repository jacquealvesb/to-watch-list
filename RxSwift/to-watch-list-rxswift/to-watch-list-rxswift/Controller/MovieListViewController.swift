//
//  MovieListViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 10/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    // Objects
    var segmentedController: UISegmentedControl!
    var tableView: MoviesListTableView = MoviesListTableView(frame: CGRect.zero)
    var viewModel: MovieListViewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
        
        // Add table view to screen
        self.view.addSubview(tableView)
        self.setupTableView()
    }
    
    func layout() {
        // Set background color
        self.view.backgroundColor = .white
        
        // Set segment controller buttons
        let items = ["To Watch", "Watched"]
        
        segmentedController = UISegmentedControl(items: items)
        segmentedController.selectedSegmentIndex = 0
        
        self.navigationItem.titleView = segmentedController
    }
    
    func setupTableView() {
        self.tableView.register(MovieToWatchCell.self, forCellReuseIdentifier: "MovieToWatchCell")
        self.tableView.register(WatchedMovieCell.self, forCellReuseIdentifier: "WatchedMovieCell")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
}

extension MovieListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedController.selectedSegmentIndex == 0 {
            return self.viewModel.toWatchMovies.count
        } else {
            return self.viewModel.watchedMovies.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if segmentedController.selectedSegmentIndex == 0 {
            let movie = self.viewModel.toWatchMovies[indexPath.row]
            let movieViewModel = MovieViewModel(movie: movie)
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "MovieToWatchCell", for: indexPath) as? MovieToWatchCell {
                cell.viewModel = movieViewModel
                
                return cell
            }
            
        } else {
            let movie = self.viewModel.watchedMovies[indexPath.row]
            let movieViewModel = MovieViewModel(movie: movie)
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WatchedMovieCell", for: indexPath) as? WatchedMovieCell {
                cell.viewModel = movieViewModel
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var movie: Movie!
        
        if segmentedController.selectedSegmentIndex == 0 {
            movie = self.viewModel.toWatchMovies[indexPath.row]
        } else {
            movie = self.viewModel.watchedMovies[indexPath.row]
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsView = MovieDetailsViewController(movie: movie)
        navigationController?.pushViewController(detailsView, animated: true)
    }
}
