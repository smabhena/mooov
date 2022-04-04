//
//  HomePageViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/27.
//

import UIKit

class HomePageViewController: UIViewController {
    private lazy var viewModel = HomePageViewModel(delegate: self, repository: MovieRepository())

    override func viewDidLoad() {
        viewModel.newRelease()
        super.viewDidLoad()
    }
}

extension HomePageViewController: HomePageViewModelDelegate {
    func showError(error: String) {
        self.displayAlert(title: "Failed to fetch movies",
                          message: error,
                          buttonTitle: "Ok")
    }
}
