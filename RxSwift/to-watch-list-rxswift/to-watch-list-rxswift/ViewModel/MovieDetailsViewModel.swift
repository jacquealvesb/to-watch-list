//
//  MovieDetailsViewModel.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 20/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import Foundation

class MovieDetailsViewModel {
    let viewModel: MovieViewModel
    
    var title: String {
        return viewModel.name
    }
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
    }
}
