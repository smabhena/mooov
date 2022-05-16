//
//  AddReviewViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/09.
//

import UIKit

class AddReviewViewController: UIViewController {
    private lazy var viewModel = ReviewViewModel(delegate: self,
                                                 repository: ReviewRepository())
    
    @IBOutlet private weak var reviewTitle: UITextField!
    @IBOutlet private weak var reviewContent: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func addReviewPressed() {
        viewModel.saveReview(title: reviewTitle.text,
                             content: reviewContent.text)
    }
}

extension AddReviewViewController: ReviewViewModelDelegate {
    func clearTextFields() {
        self.reviewTitle.text = ""
        self.reviewContent.text = ""
    }
    
    func showAlert(message: String) {
        self.displayAlert(title: "Added your review",
                          message: message,
                          buttonTitle: "Ok")
    }
    
    func showError(error: String) {
        self.displayAlert(title: "Failed to add your review",
                          message: error,
                          buttonTitle: "Ok")
    }
}
