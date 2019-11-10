//
//  SearchMovieViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 10/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class SearchMovieViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
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
}
