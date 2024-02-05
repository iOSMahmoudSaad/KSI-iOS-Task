//
//  DefaultHomeRepo.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation
 
 
class DefaultHomeRepo:HomeRepo {
    
    var firstTimeRun:Bool =  UserDefaults.standard.bool(forKey: Constants.firstTime.rawValue)
    var productListLDBCLient:ProductListLDBCLient
    init(productListLDBCLient:ProductListLDBCLient) {
        
        self.productListLDBCLient = productListLDBCLient
    }
    func getProductList(_ completion: @escaping (ProductList?, String?) -> Void) {
        
        if !firstTimeRun {
            
            getProductListFromApi { productList, error in
                
                if let productList {
                    
                    self.productListLDBCLient.saveProductList(producList: .init(products: productList.products, total: productList.total, skip: productList.skip, limit: productList.limit)){ sucess,error in
                        
                        if let sucess {
                            
                            UserDefaults.standard.set(true, forKey: Constants.firstTime.rawValue)
                            completion(sucess,nil)
                        }
                        if let error {
                            
                            completion(nil,error)
                        }
                    }
                }
                if let error{
                    
                    completion(nil,error)
                }
            }
        }else{
            
            getProductListFromLDB(completion)
        }
    }
    private func getProductListFromLDB(_ completion: @escaping (ProductList?, String?) -> Void){
        productListLDBCLient.getProductList(completion)
    }
    private func getProductListFromApi(_ completion: @escaping (ProductListDTO?, String?) -> Void){
        
        HomeClient.getProductList { success, failure, ReqErr in
            if let success {
                
                completion(success,nil)
            }
            if let failure {
                
                completion(nil,failure)
            }
            if let ReqErr {
                
                print(ReqErr)
                completion(nil,ReqErr.localizedDescription)
            }
        }
    }
    func addFaveorite(id: String, _ completion: @escaping (ProductList?, String?) -> Void) {
        
        productListLDBCLient.toggleFavorite(id: id, completion)
    }
}
