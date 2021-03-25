//
//  ListItemsModel.swift
//  USPolo-Ecommerse
//
//  Created by Mohammed Ramshad K on 24/03/21.
//

import Foundation

class Product{
    var product_id : String = ""
    var name : String = ""
    var image : String = ""
    var price : String = ""
    var rating : String = ""
    var category : String = ""
    
    init(product_id: String, name: String, image: String, price: String, rating: String, category: String = "Shirt") {
        self.product_id = product_id
        self.name = name
        self.image = image
        self.price = price
        self.rating = rating
        self.category = category
    }
    
    init() {
    }
    
}
