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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
        
        // Add table view to screen
        self.view.addSubview(tableView)
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
}
