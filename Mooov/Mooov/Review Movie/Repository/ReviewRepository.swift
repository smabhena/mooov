//
//  ReviewRepository.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/05/04.
//

import Foundation
import FirebaseDatabase

typealias CreateReview = ((Result<Bool, APIError>) -> Void)

protocol ReviewRepositoryType: AnyObject {
    func createReview(completion: @escaping CreateReview)
}

class ReviewRepository: ReviewRepositoryType {
    private let database = Database.database().reference()
    
    func createReview(completion: @escaping CreateReview) {
        let object: [String: Any] = [
            "name" : "Dunkirk" as NSObject,
            "content" : "blah"
        ]
//        do {
//            let object = Review(name: <#T##String?#>, content: <#T##String?#>)
//            database.child("reviews").setValue(object)
//            DispatchQueue.main.async {
//                completion(.success(true))
//            }
//        } catch {
//            DispatchQueue.main.async {
//                completion(.failure(.serverError))
//            }
//        }
    }
}
