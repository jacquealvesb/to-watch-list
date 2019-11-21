//
//  MovieDetailsViewController.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 20/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    var viewModel: MovieDetailsViewModel!
    var detailsView: MovieDetailsView = MovieDetailsView(frame: CGRect.zero)
    
    convenience init(movieViewModel: MovieViewModel) {
        self.init()
        
        self.viewModel = MovieDetailsViewModel(viewModel: movieViewModel)
        self.detailsView.viewModel = movieViewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.layout()
    }
    
    func layout() {
        // Set background color
        self.view.backgroundColor = .white
        
        // Set navbar title
        self.title = self.viewModel.title
        
        // Setup view
        self.view.addSubview(detailsView)
        self.setConstraints()
    }
}

// MARK: - Constraints
extension MovieDetailsViewController {
    func setConstraints() {
        self.detailsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.detailsView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.detailsView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.detailsView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.detailsView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
}
