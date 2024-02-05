//
//  ProductModel.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation

struct ProductList {
    
    let products: [Product]
    let total, skip, limit: Int
}

struct Product {
    
    let id:String
    let name:String
    let description: String
    let price: Int
    let thumbnail: String
    let isFav:Bool
}
