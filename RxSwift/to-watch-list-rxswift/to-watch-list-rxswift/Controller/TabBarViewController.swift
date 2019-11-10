//
//  TabBarViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 10/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Create View Controllers
        let movieListViewController = UINavigationController(rootViewController: MovieListViewController())
        let searchMovieViewController = UINavigationController(rootViewController: SearchMovieViewController())
        
        // Set the View Controller tab items
        movieListViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage.init(systemName: "film"), tag: 0)
        searchMovieViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        // Set the Controller's tab items
        let tabBarList = [movieListViewController, searchMovieViewController]
        
        viewControllers = tabBarList
    }
}
