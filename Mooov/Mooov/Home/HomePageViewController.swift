//
//  HomePageViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/27.
//

import UIKit

class HomePageViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var viewModel = HomePageViewModel(delegate: self, repository: MovieRepository())

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
}

extension HomePageViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                          as? CustomCollectionViewCell) else {
            return UICollectionViewCell()
        }
        
        guard let movie = viewModel.movie(atIndex: indexPath.row) else {
            return UICollectionViewCell()
        }
        
        cell.updateCellContent(movie.poster, movie.title, movie.genre)
        
        return cell
    }
}

extension HomePageViewController: HomePageViewModelDelegate {
    func showError(error: String) {
        self.displayAlert(title: "Failed to fetch movies",
                          message: error,
                          buttonTitle: "Ok")
    }
    
    func reloadView() {
        collectionView.reloadData()
    }
}
