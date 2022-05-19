//
//  ReviewRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/04.
//

import Foundation
import FirebaseDatabase

typealias CreateReview = ((Result<Void, APIError>) -> Void)
typealias FetchReview = ((Result<[Review], APIError>) -> Void)

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
    
    func fetchReviews(completion: @escaping FetchReview) {
        database.child("reviews").getData(completion: { error, snapshot in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(.serverError))
                }
                return
            }
            do {
                let data = try JSONSerialization.data(withJSONObject: snapshot.value)
                let object = try JSONDecoder().decode([Review].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(object))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.parsingError))
                }
            }
        })
    }

}
