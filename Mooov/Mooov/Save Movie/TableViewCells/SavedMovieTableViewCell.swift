//
//  SavedMovieTableViewCell.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/22.
//

import Foundation
import UIKit

class SavedMovieTableViewCell: UITableViewCell {
    @IBOutlet weak private var movieImageView: UIImageView!
    @IBOutlet weak private var movieTitleTextView: UITextView!
    
    func updateCellContent(_ movieImage: String,_ movieTitle: String) {
        let imageURL = URL(string: movieImage)
        guard let imageURL = imageURL else { return }
        movieImageView.load(url: imageURL)
        movieTitleTextView.text = movieTitle
    }
}
