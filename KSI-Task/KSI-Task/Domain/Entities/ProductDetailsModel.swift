//
//  ProductDetailsModel.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 06/02/2024.
//

import Foundation

struct ProductDetails {
    
    let id: String
    let title, description: String
    let price: Int
    let discountPercentage, rating: Double
    let stock: Int
    let brand, category: String
    let thumbnail: String
    let images: [String]
}
