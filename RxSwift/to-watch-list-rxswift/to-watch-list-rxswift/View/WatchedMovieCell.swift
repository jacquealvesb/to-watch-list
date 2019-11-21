//
//  WatchedMovieCell.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class WatchedMovieCell: UITableViewCell, MovieCell {
    var posterImageView: UIImageView = UIImageView(frame: CGRect.zero)
    var nameLabel: UILabel = UILabel(frame: CGRect.zero)
    var reviewLabel: UILabel = UILabel(frame: CGRect.zero)
    var watchedDateLabel: UILabel = UILabel(frame: CGRect.zero)
    var ratingLabel: UILabel = UILabel(frame: CGRect.zero)
    
    var viewModel: MovieViewModel! {
        didSet {
            self.nameLabel.text = self.viewModel.name
            self.reviewLabel.text = self.viewModel.review
            self.watchedDateLabel.text = self.viewModel.watchedDate
            self.ratingLabel.text = self.viewModel.rating
            self.downloadImage()
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
        self.setupReview()
        self.setupWatchedDate()
        self.setupRating()
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
    
    func setupReview() {
        self.reviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.reviewLabel.numberOfLines = 3
        self.reviewLabel.sizeToFit()
        
        self.addSubview(reviewLabel)
    }
    
    func setupWatchedDate() {
        self.watchedDateLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        
        self.addSubview(watchedDateLabel)
    }
    
    func setupRating() {
        self.ratingLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        self.addSubview(ratingLabel)
    }
    
    func downloadImage() {
        URLSession.shared.dataTask(with: self.viewModel.posterURL) { (data, _, _) in
            if let data = data {
                self.imageView?.image = UIImage(data: data)
            }
        }
    }
}

// MARK: - Constraints
extension WatchedMovieCell {
    func setConstraints() {
        self.setPosterContraints()
        self.setNameConstraints()
        self.setRatingConstraints()
        self.setWatchedDateConstraints()
        self.setReviewConstraints()
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
    
    func setRatingConstraints() {
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.ratingLabel.bottomAnchor.constraint(equalTo: self.posterImageView.bottomAnchor),
            self.ratingLabel.heightAnchor.constraint(equalToConstant: 20),
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setWatchedDateConstraints() {
        self.watchedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.watchedDateLabel.bottomAnchor.constraint(equalTo: self.ratingLabel.topAnchor),
            self.watchedDateLabel.heightAnchor.constraint(equalToConstant: 20),
            self.watchedDateLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.watchedDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setReviewConstraints() {
        self.reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.reviewLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 5),
            self.reviewLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
