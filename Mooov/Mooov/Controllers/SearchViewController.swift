//
//  ViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func buttonPressed(_ sender: Any) {
        let searchResultsPage = storyboard?.instantiateViewController(identifier: "searchResultsVC") as? SearchResultsViewController

        if let searchResultsPage = searchResultsPage {
            if let text = searchField.text {
                searchResultsPage.searchText = text
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? SearchResultsViewController
        destinationVC?.searchText = searchField.text ?? "None"
    }
}
