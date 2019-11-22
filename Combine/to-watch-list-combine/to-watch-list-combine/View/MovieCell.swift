//
//  MovieCell.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

protocol MovieCell: UITableViewCell {
    var posterImageView: UIImageView { get set }
    var titleLabel: UILabel { get set }
    var viewModel: MovieViewModel! { get set }
    
    func setConstraints()
}
