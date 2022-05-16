//
//  ReviewRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/04.
//

import Foundation
import FirebaseDatabase

typealias CreateReview = ((Result<Void, APIError>) -> Void)

protocol ReviewRepositoryType: AnyObject {
    func createReview(title: String, content: String, completion: @escaping CreateReview)
}

class ReviewRepository: ReviewRepositoryType {
    private let database = Database.database().reference()
    
    func createReview(title: String, content: String, completion: @escaping CreateReview) {
        let review = Review(title: title, content: content)
        
        do {
            let data = try JSONEncoder().encode(review)
            let json = try JSONSerialization.jsonObject(with: data)
            
            database.child("reviews").observeSingleEvent(of: .value, with: { snapshot in
                self.database.child("reviews")
                    .child("\(snapshot.childrenCount)")
                    .setValue(json)
                completion(.success(()))
            })
        } catch {
            print("an error occurred", error)
            completion(.failure(.internalError))
        }
    }
}
