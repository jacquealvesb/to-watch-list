//
//  SearchMovieViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 10/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMovieViewController: UIViewController {
    // Objects
    var tableView: MoviesListTableView = MoviesListTableView(frame: CGRect.zero)
    var infoLabel: UILabel = UILabel(frame: CGRect.zero)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect.zero)

    // Variables
    var viewModel: SearchMovieViewViewModel!
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
        
        let searchBar = self.navigationItem.searchController!.searchBar
        // Create view model
        self.viewModel = SearchMovieViewViewModel(query: searchBar.rx.text.orEmpty.asDriver(), tmdbService: TMDBService.shared)
        
        // Handle keyboard resign
        searchBar.rx.searchButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned searchBar] in
                searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        searchBar.rx.cancelButtonClicked
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [unowned searchBar] in
                searchBar.resignFirstResponder()
            }).disposed(by: disposeBag)
        
        // Setup subviews
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
        
        let search = UISearchController(searchResultsController: nil)
//        search.searchResultsUpdater = self
        self.navigationItem.searchController = search
    }
    
    func setupInfoLabel() {
        self.view.addSubview(infoLabel)
        
        self.infoLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.infoLabel.textColor = UIColor.secondaryLabel
        self.infoLabel.textAlignment = .center
        
        self.viewModel.info
            .drive(onNext: { [unowned self] info in
                self.infoLabel.isHidden = !self.viewModel.hasInfo
                self.infoLabel.text = info
            }).disposed(by: disposeBag)
    }
    
    func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        
        self.viewModel.isFetching
            .drive(self.activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
        
        self.tableView.register(MovieToWatchCell.self, forCellReuseIdentifier: "MovieToWatchCell")
        self.tableView.dataSource = self
        
        self.viewModel.movies
            .drive(onNext: { [unowned self] _ in
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
    }
}

// MARK: - TableView Data Source
extension SearchMovieViewController: UITableViewDataSource {
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
