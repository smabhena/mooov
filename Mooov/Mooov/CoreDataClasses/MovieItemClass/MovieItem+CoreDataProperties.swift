//
//  MovieItem+CoreDataProperties.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/03/10.
//
//

import Foundation
import CoreData

extension MovieItem {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<MovieItem> {
        return NSFetchRequest<MovieItem>(entityName: "MovieItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var image: String?
}
