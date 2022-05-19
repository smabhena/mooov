//
//  ReviewViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/04.
//

import UIKit

class ReviewViewController: UIViewController {
    private lazy var viewModel = ReviewViewModel(delegate: self,
                                                 repository: ReviewRepository())
    
    @IBOutlet private weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        viewModel.fetchReviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchReviews()
    }
    
    @IBAction private func buttonPressed(_ sender: Any) {
        let addReviewScreen = storyboard?.instantiateViewController(identifier: "addReviewVC") as? AddReviewViewController
        
        if let addReviewScreen = addReviewScreen {
            if let navigator = self.navigationController {
                navigator.pushViewController(addReviewScreen, animated: true)
            }
        }
    }
    
    private func setUpTableView() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        reviewTableView.rowHeight = 120
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.reviewCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        guard let review = viewModel.review(atIndex: indexPath.row) else {
            return UITableViewCell()
        }
        
        cell.updateCellContent(review.title, review.content)
        return cell
    }
}

extension ReviewViewController: ReviewViewModelDelegate {
    func clearTextFields() {}
    
    func showAlert(message: String) {}
    
    func showError(error: String) {
        self.displayAlert(title: "Failed to fetch your reviews",
                          message: error,
                          buttonTitle: "Ok")
    }
    
    func reload() {
        reviewTableView.reloadData()
    }
}
