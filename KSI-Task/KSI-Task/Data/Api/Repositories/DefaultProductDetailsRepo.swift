//
//  DefaultProductDetailsRepo.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 06/02/2024.
//

import Foundation

class DefaultProductDetailsRepo: ProductDetailsRepo {
    
    var productListLDBCLient:ProductListLDBCLient
    
    init(productListLDBCLient:ProductListLDBCLient) {
        
        self.productListLDBCLient = productListLDBCLient
    }
    func getProducDetails(id: String, _ completion: @escaping (ProductDetails?, String?) -> Void) {
        
        productListLDBCLient.getProductDetails(id: id, completion)
    }
    
    
}
