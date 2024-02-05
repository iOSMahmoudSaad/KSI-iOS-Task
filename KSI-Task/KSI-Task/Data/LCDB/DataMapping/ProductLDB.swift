//
//  ProductLDB.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation


import Foundation
import RealmSwift
// MARK: - Product
class ProductLDB: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var title:String
    @Persisted var descriptions: String
    @Persisted var price: Int
    @Persisted var discountPercentage:Double
    @Persisted var rating: Double
    @Persisted var stock: Int
    @Persisted var brand: String
    @Persisted var category: String
    @Persisted var thumbnail: String
    @Persisted var images: RealmSwift.List<String>
    @Persisted var isFavourite:Bool = false
    @Persisted(originProperty: "products") var productList :LinkingObjects<ProductListLDB>
    
   convenience init( title: String, descriptions: String, price: Int, discountPercentage: Double, rating: Double, stock: Int, brand: String, category: String, thumbnail: String, images: RealmSwift.List<String>) {
       
        self.init()
        self.title = title
        self.descriptions = descriptions
        self.price = price
        self.discountPercentage = discountPercentage
        self.rating = rating
        self.stock = stock
        self.brand = brand
        self.category = category
        self.thumbnail = thumbnail
        self.images = images
    }
    func setImagesFromArr(_ arr:[String]){
        
        images.append(objectsIn: arr)
    }
}
extension ProductLDB {
    
    func toDomain()->Product {
        
        return .init(id:_id.stringValue, name: title, description: descriptions, price: price, thumbnail: thumbnail, isFav: isFavourite)
    }
}
