//
//  Constants.swift
//  Mooov
//
//  Created by Sinothando Mabhena on 2022/02/24.
//

import Foundation
import UIKit

struct Constants {
    static let endpoint = Endpoint()
    
    static let apiKey = "30e3b219ddmsh177158ef21b7ff9p1aca16jsn64191f5fee0d"
    
    static let apiHost = "movie-database-alternative.p.rapidapi.com"
    
    static let viewContext = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
}
