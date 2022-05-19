//
//  ReviewViewModel.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/04.
//

import Foundation

protocol ReviewViewModelDelegate: AnyObject {
    func clearTextFields()
    func showAlert(message: String)
    func showError(error: String)
    func reload()
}

class ReviewViewModel {
    private var repository: ReviewRepository?
    private weak var delegate: ReviewViewModelDelegate?
    private var reviews: [Review]?
    private var title: String?
    private var content: String?
    
    init(delegate: ReviewViewModelDelegate, repository: ReviewRepository) {
        self.delegate = delegate
        self.repository = repository
    }
    
    var reviewCount: Int {
        return reviews?.count ?? 0
    }
    
    func review(atIndex: Int) -> Review? {
        return reviews?[atIndex]
    }
    
    func saveReview(title: String?, content: String?) {
        guard let title = title else { return }
        guard let content = content else { return }
        
        repository?.createReview(title: title, content: content, completion: { [weak self] result in
            switch result {
            case .success:
                self?.delegate?.showAlert(message: title)
                self?.delegate?.clearTextFields()
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
        })
    }
    
    func fetchReviews() {
        repository?.fetchReviews(completion: {[weak self] result in
            switch result {
            case .success(let result):
                self?.reviews = result
                print(self?.reviews)
                self?.delegate?.reload()
            case .failure(let error):
                self?.delegate?.showError(error: error.rawValue)
            }
        })
    }
}
