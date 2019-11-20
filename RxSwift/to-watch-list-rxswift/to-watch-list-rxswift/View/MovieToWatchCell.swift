//
//  MovieToWatchCell.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieToWatchCell: UITableViewCell, MovieCell {
    var posterImageView: UIImageView = UIImageView(frame: CGRect.zero)
    var nameLabel: UILabel = UILabel(frame: CGRect.zero)
    var overviewLabel: UILabel = UILabel(frame: CGRect.zero)
    var releaseDateLabel: UILabel = UILabel(frame: CGRect.zero)
    
    var viewModel: MovieViewModel! {
        didSet {
            if let data = self.viewModel.poster, let poster = UIImage(data: data) {
                self.posterImageView.image = poster
            }
            self.nameLabel.text = self.viewModel.name
            self.overviewLabel.text = self.viewModel.overview
            self.releaseDateLabel.text = self.viewModel.releaseDate
        }
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.layout()
        self.setConstraints()
    }
    
    func layout() {
        self.setupPoster()
        self.setupName()
        self.setupOverview()
        self.setupReleaseDate()
    }
    
    func setupPoster() {
        self.posterImageView.contentMode = .scaleAspectFit
        self.posterImageView.backgroundColor = .black
        
        self.addSubview(posterImageView)
    }
    
    func setupName() {
        self.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        self.addSubview(nameLabel)
    }
    
    func setupOverview() {
        self.overviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.overviewLabel.numberOfLines = 3
        self.overviewLabel.sizeToFit()
        
        self.addSubview(overviewLabel)
    }
    
    func setupReleaseDate() {
        self.releaseDateLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        self.addSubview(releaseDateLabel)
    }
}

// MARK: - Constraints
extension MovieToWatchCell {
    func setConstraints() {
        self.setPosterContraints()
        self.setNameConstraints()
        self.setReleaseDateConstraints()
        self.setOverviewConstraints()
    }
    
    func setPosterContraints() {
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.posterImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10),
            self.posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor, multiplier: 1/1.5)
        ])
    }
    
    func setNameConstraints() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.nameLabel.topAnchor.constraint(equalTo: self.posterImageView.topAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 20),
            self.nameLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setReleaseDateConstraints() {
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.releaseDateLabel.bottomAnchor.constraint(equalTo: self.posterImageView.bottomAnchor),
            self.releaseDateLabel.heightAnchor.constraint(equalToConstant: 20),
            self.releaseDateLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.releaseDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setOverviewConstraints() {
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.overviewLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5),
            self.overviewLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
