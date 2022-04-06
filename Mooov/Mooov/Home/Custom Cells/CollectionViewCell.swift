//
//  CollectionViewCell.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/04/04.
//

import Foundation
import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieGenreLabel: UILabel!
    
    func updateCellContent(_ movieImage: String,_ movieTitle: String, _ movieGenre: String) {
        guard let imageURL = URL(string: movieImage) else { return }
        movieImageView.load(url: imageURL)
        movieTitleLabel.text = movieTitle
        let genre = movieGenre.components(separatedBy: ",")
        movieGenreLabel.text = genre[0]
    }
}
