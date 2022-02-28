//
//  ViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var searchField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction private func buttonPressed(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "searchResultsVC") as? SearchResultsViewController
        
        if let vc = vc {
            if let text = searchField.text {
                vc.searchText = text
                vc.modalPresentationStyle = .fullScreen
            }
            present(vc, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as? SearchResultsViewController
        destinationVC?.searchText = searchField.text ?? "None"
    }
}
