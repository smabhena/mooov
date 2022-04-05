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
    
    func updateCellContent(_ movieImage: String,_ movieTitle: String) {
        let imageURL = URL(string: movieImage)
        guard let imageURL = imageURL else { return }
        movieImageView.load(url: imageURL)
        movieTitleLabel.text = movieTitle
    }
}
