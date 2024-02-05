//
//  ProductListDTO.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation


import Foundation
 
struct ProductListDTO: Codable {
    
    let products: [ProductDTO]
    let total, skip, limit: Int
}

 
struct ProductDTO: Codable {
    
    let id: Int
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}

