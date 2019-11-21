//
//  SearchMovieViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 10/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {
    var tableView: MoviesListTableView = MoviesListTableView(frame: CGRect.zero)
    var infoLabel: UILabel = UILabel(frame: CGRect.zero)
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect.zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
        self.setConstraints()
        self.setupTableView()
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
        
        // Setup subviews
        self.setupInfoLabel()
        self.setupActivityIndicator()
    }
    
    func setupInfoLabel() {
        self.view.addSubview(infoLabel)
        
        self.infoLabel.font = UIFont.preferredFont(forTextStyle: .body)
        self.infoLabel.textColor = UIColor.secondaryLabel
        self.infoLabel.textAlignment = .center
    }
    
    func setupActivityIndicator() {
        self.view.addSubview(activityIndicator)
        
        self.activityIndicator.startAnimating()
    }
    
    func setupTableView() {
        self.view.addSubview(tableView)
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
