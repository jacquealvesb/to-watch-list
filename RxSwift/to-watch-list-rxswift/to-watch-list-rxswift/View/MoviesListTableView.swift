//
//  MoviesListTableView.swift
//  to-watch-list-rxswift
//
//  Created by Jacqueline Alves on 02/11/19.
//  Copyright © 2019 jacquelinealves. All rights reserved.
//

import UIKit

class MoviesListTableView: UITableView {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        self.setConstraints()
        self.rowHeight = 120
        self.separatorStyle = .none
    }
}

// MARK: - Constraints
extension MoviesListTableView {
    func setConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        if let parent = self.superview {
            NSLayoutConstraint.activate([
                self.topAnchor.constraint(equalTo: parent.topAnchor),
                self.bottomAnchor.constraint(equalTo: parent.bottomAnchor),
                self.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 10),
                self.trailingAnchor.constraint(equalTo: parent.trailingAnchor, constant: -10)
            ])
        }
    }
}
