//
//  ReviewTableViewCell.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/19.
//

import Foundation
import UIKit

class ReviewTableViewCell: UITableViewCell {
    @IBOutlet weak private var reviewTitleLabel: UILabel!
    @IBOutlet weak private var reviewContentLabel: UITextView!
    
    func updateCellContent(_ reviewTitle: String,_ reviewContent: String) {
        reviewTitleLabel.text = reviewTitle
        reviewContentLabel.text = reviewContent
    }
}
