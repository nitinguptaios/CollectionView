//
//  CatelougeDataModel.swift
//  Nitin_Gupta
//
//  Created by iPHSTech 34 on 14/05/22.
//

import Foundation

class CatelougeDataModel: NSObject {
    
    var image: String?
    var price: Double?
    var title: String?
    
    init(image: String, price: Double, title: String) {
        self.image = image
        self.price = price
        self.title = title
    }
}

