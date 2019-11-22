//
//  SearchMovieViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 10/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import Combine

class SearchMovieViewController: UIViewController {
    // Objects
    var tableView: MoviesListTableView = MoviesListTableView(frame: CGRect.zero)
    var infoLabel: UILabel = UILabel(frame: CGRect.zero)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect.zero)
    
    // Variables
    var viewModel: SearchMovieViewViewModel!
    var query = PassthroughSubject<String?, Never>() // String written in search bar

    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
        
        // Create view model
        self.viewModel = SearchMovieViewViewModel(query: query.eraseToAnyPublisher(), // Send query string to be subscribed with search method
                                                  tmdbService: TMDBService.shared)
        
        // Setup subviews
        self.setupSearchBar()
        self.setupTableView()
        self.setupInfoLabel()
        self.setupActivityIndicator()

        self.setConstraints()
    }

    func layout() {
        // Set background color
        self.view.backgroundColor = .white

        // Set Search controller
        self.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setupSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        
        self.navigationItem.searchController = search
        self.navigationItem.searchController!.searchBar.delegate = self // Set the serach bar delegate to this
        
        self.query.send("")
    }

    func setupInfoLabel() {
        self.view.addSubview(infoLabel)
        self.infoLabel.isUserInteractionEnabled = false

        self.infoLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.infoLabel.textColor = UIColor.secondaryLabel
        self.infoLabel.textAlignment = .center
        
        _ = self.viewModel.$info // Listen to changes in info text and writes it to label
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] info in
                self.infoLabel.isHidden = !self.viewModel.hasInfo
                self.infoLabel.text = info
            }
    }

    func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        self.activityIndicator.isUserInteractionEnabled = false
        
        _ = self.viewModel.$isFetching // Listen to changes in isFetching and binds it to activity indicator animation
            .receive(on: DispatchQueue.main)
            .sink { (fetching) in
                if fetching {
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.stopAnimating()
                }
            }
    }

    func setupTableView() {
        self.view.addSubview(tableView)

        self.tableView.register(MovieToWatchCell.self, forCellReuseIdentifier: "MovieToWatchCell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        _ = self.viewModel.$movies
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] _ in
                self.tableView.reloadData()
            }
    }
}

// MARK: - SearchBar
extension SearchMovieViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.query.send(searchBar.text) // Send changes in query string value
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.query.send(searchBar.text) // Send changes in query string value
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}

// MARK: - TableView
extension SearchMovieViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.numberOfMovies
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MovieToWatchCell", for: indexPath) as? MovieToWatchCell else {
            return UITableViewCell()
        }
        
        if let viewModel = viewModel.viewModelForMovie(at: indexPath.row) {
            cell.viewModel = viewModel
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if let viewModel = viewModel.viewModelForMovie(at: indexPath.row) {
            let detailsView = MovieDetailsViewController(movieViewModel: viewModel)
            
            navigationController?.pushViewController(detailsView, animated: true)
        }
    }
}

// MARK: - Constraints
extension SearchMovieViewController {
    func setConstraints() {
        self.setInfoConstraints()
        self.setActivityIndicatorConstraints()
    }
    
    func setInfoConstraints() {
        self.infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.infoLabel.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.infoLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.infoLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.infoLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
    
    func setActivityIndicatorConstraints() {
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.activityIndicator.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.activityIndicator.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.activityIndicator.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.activityIndicator.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}
