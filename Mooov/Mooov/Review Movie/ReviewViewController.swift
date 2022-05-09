//
//  ReviewViewController.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/04.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet private weak var reviewTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
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
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath)
        cell.textLabel?.text = "Review"
        return cell
    }
}
