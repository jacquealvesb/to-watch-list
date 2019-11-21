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
    var titleLabel: UILabel = UILabel(frame: CGRect.zero)
    var reviewLabel: UILabel = UILabel(frame: CGRect.zero)
    var watchedDateLabel: UILabel = UILabel(frame: CGRect.zero)
    var ratingLabel: UILabel = UILabel(frame: CGRect.zero)
    
    var viewModel: MovieViewModel! {
        didSet {
            self.titleLabel.text = self.viewModel.title
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
        self.setupTitle()
        self.setupReview()
        self.setupWatchedDate()
        self.setupRating()
    }
    
    func setupPoster() {
        self.posterImageView.contentMode = .scaleAspectFit
        self.posterImageView.backgroundColor = .black
        
        self.addSubview(posterImageView)
    }
    
    func setupTitle() {
        self.titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        self.addSubview(titleLabel)
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
                DispatchQueue.main.async {
                    self.posterImageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}

// MARK: - Constraints
extension WatchedMovieCell {
    func setConstraints() {
        self.setPosterContraints()
        self.setTitleConstraints()
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
    
    func setTitleConstraints() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.titleLabel.topAnchor.constraint(equalTo: self.posterImageView.topAnchor),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 20),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
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
            self.reviewLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 5),
            self.reviewLabel.leadingAnchor.constraint(equalTo: self.posterImageView.trailingAnchor, constant: 10),
            self.reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
}
