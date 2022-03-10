//
//  ViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func buttonPressed(_ sender: Any) {
        let searchResultsPage = storyboard?.instantiateViewController(identifier: "searchResultsVC") as? SearchResultsViewController

        if let searchResultsPage = searchResultsPage {
            if let text = searchField.text {
                if text == "" {
                    self.displayAlert(title: "Search field empty",
                                      message: "Enter a movie title to search",
                                      buttonTitle: "Ok")
                    return
                } else {
                    searchResultsPage.searchText = text
                }
            }
            
            if let navigator = self.navigationController {
                navigator.pushViewController(searchResultsPage, animated: true)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? SearchResultsViewController
        destinationVC?.searchText = searchField.text ?? "None"
    }
}
