//
//  MovieDetailsView.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 20/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MovieDetailsView: UIView {
    var posterImageView: UIImageView = UIImageView(frame: CGRect.zero)
    var overviewLabel: UILabel = UILabel(frame: CGRect.zero)
    var releaseDateLabel: UILabel = UILabel(frame: CGRect.zero)
    var reviewSectionLabel: UILabel = UILabel(frame: CGRect.zero)
    var ratingLabel: UILabel = UILabel(frame: CGRect.zero)
    var reviewLabel: UILabel = UILabel(frame: CGRect.zero)
    var watchedDateLabel: UILabel = UILabel(frame: CGRect.zero)
    var watchedButton: UIButton = UIButton(frame: CGRect.zero)
    var wantToWatchButton: UIButton = UIButton(frame: CGRect.zero)
    
    var viewModel: MovieViewModel! {
        didSet {
            self.overviewLabel.text = self.viewModel.overview
            self.releaseDateLabel.text = self.viewModel.releaseDate
            self.ratingLabel.text = self.viewModel.rating
            self.reviewLabel.text = self.viewModel.review
            self.watchedDateLabel.text = self.viewModel.watchedDate
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
        self.setupOverview()
        self.setupReleaseDate()

        if self.viewModel.watched {
            self.setupReviewSection()
            self.setupRating()
            self.setupReview()
            self.setupWatchedDate()
        } else {
            self.setupWatchedButton()
            if !self.viewModel.wantToWatch {
                self.setupToWatchButton()
            }
        }
    }
    
    func setupPoster() {
        self.posterImageView.contentMode = .scaleAspectFit
        self.posterImageView.backgroundColor = .black
        
        self.addSubview(posterImageView)
    }
    
    func setupOverview() {
        self.overviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.overviewLabel.numberOfLines = 0
        
        self.addSubview(overviewLabel)
    }
    
    func setupReleaseDate() {
        self.releaseDateLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        self.releaseDateLabel.textAlignment = .right
        
        self.addSubview(releaseDateLabel)
    }
    
    func setupReviewSection() {
        self.reviewSectionLabel.text = "What you thought about it"
        self.reviewSectionLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        self.addSubview(reviewSectionLabel)
    }
    
    func setupRating() {
        self.ratingLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        
        self.addSubview(ratingLabel)
    }
    
    func setupReview() {
        self.reviewLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        self.reviewLabel.numberOfLines = 0
        
        self.addSubview(reviewLabel)
    }
    
    func setupWatchedDate() {
        self.watchedDateLabel.font = UIFont.preferredFont(forTextStyle: .caption2)
        self.watchedDateLabel.textAlignment = .right
        
        self.addSubview(watchedDateLabel)
    }
    
    func setupWatchedButton() {
        self.watchedButton.setTitle("I already watched it!", for: .normal)
        self.watchedButton.setTitleColor(.systemBlue, for: .normal)
        
        self.addSubview(watchedButton)
    }
    
    func setupToWatchButton() {
        self.wantToWatchButton.setTitle("I want to watch it!", for: .normal)
        self.wantToWatchButton.setTitleColor(.systemBlue, for: .normal)
        
        self.addSubview(wantToWatchButton)
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
extension MovieDetailsView {
    func setConstraints() {
        self.setPosterContraints()
        self.setOverviewContraints()
        self.setReleaseDateConstraints()

        if self.viewModel.watched {
            self.setReviewSectionConstraints()
            self.setRatingConstraints()
            self.setReviewConstraints()
            self.setWatchedDateConstraints()
        } else {
            self.setWatchedButtonConstraints()
            if !self.viewModel.wantToWatch {
                self.setWantToWatchButtonConstraints()
            }
        }
    }
    
    func setPosterContraints() {
        self.posterImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.posterImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.posterImageView.heightAnchor.constraint(equalToConstant: 270),
            self.posterImageView.widthAnchor.constraint(equalTo: self.posterImageView.heightAnchor, multiplier: 1/1.5),
            self.posterImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setOverviewContraints() {
        self.overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.overviewLabel.topAnchor.constraint(equalTo: self.posterImageView.bottomAnchor, constant: 10),
            self.overviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setReleaseDateConstraints() {
        self.releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.releaseDateLabel.topAnchor.constraint(equalTo: self.overviewLabel.bottomAnchor, constant: 5),
            self.releaseDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.releaseDateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setReviewSectionConstraints() {
        self.reviewSectionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.reviewSectionLabel.topAnchor.constraint(equalTo: self.releaseDateLabel.bottomAnchor, constant: 50),
            self.reviewSectionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.reviewSectionLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    func setRatingConstraints() {
        self.ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.ratingLabel.leadingAnchor.constraint(equalTo: self.reviewSectionLabel.trailingAnchor, constant: 5),
            self.ratingLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.ratingLabel.heightAnchor.constraint(equalToConstant: 30),
            self.ratingLabel.centerYAnchor.constraint(equalTo: self.reviewSectionLabel.centerYAnchor)
        ])
    }
    
    func setReviewConstraints() {
        self.reviewLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.reviewLabel.topAnchor.constraint(equalTo: self.reviewSectionLabel.bottomAnchor, constant: 10),
            self.reviewLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.reviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        ])
    }
    
    func setWatchedDateConstraints() {
        self.watchedDateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.watchedDateLabel.topAnchor.constraint(equalTo: self.reviewLabel.bottomAnchor, constant: 5),
            self.watchedDateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.watchedDateLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func setWatchedButtonConstraints() {
        self.watchedButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.watchedButton.topAnchor.constraint(equalTo: self.releaseDateLabel.bottomAnchor, constant: 50),
            self.watchedButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.watchedButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    func setWantToWatchButtonConstraints() {
        self.wantToWatchButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.wantToWatchButton.topAnchor.constraint(equalTo: self.watchedButton.bottomAnchor, constant: 5),
            self.wantToWatchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.wantToWatchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
