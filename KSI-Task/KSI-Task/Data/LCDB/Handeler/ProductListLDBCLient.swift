//
//  ProductList.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation
import RealmSwift

class ProductListLDBCLient {
    
     let realm = try? Realm()
    static let shared = ProductListLDBCLient()
    private init(){}
    
     func getProductList(_ completion:@escaping (_ sucess:ProductList?,_ failure:String?)->Void) {
        guard let result =  realm?.objects(ProductListLDB.self) else {
            
            completion(nil,"Can not fetch data")
            return
        }
        guard let productList = result.first?.toDomian() else {
            
            completion(nil,"No Product List")
            return
        }
        completion(productList,nil)
    }
    
    func saveProductList(producList:ProductListDTO,_ completion:@escaping (_ sucess:ProductList?,_ failure:String?)->Void){
        do {
            
            try realm?.write({
                
                let pList = ProductListLDB()
                pList.limit = producList.limit
                pList.skip = producList.skip
                pList.total = producList.total
                let productLDBList = List<ProductLDB>()
                producList.products.forEach { product in
                    let productImagesList:List<String> = List<String>()
                    productImagesList.append(objectsIn: product.images)
                    productLDBList.append(.init(title: product.title, descriptions: product.description, price: product.price, discountPercentage: product.discountPercentage, rating: product.rating, stock: product.stock, brand: product.brand, category: product.category, thumbnail: product.thumbnail, images: productImagesList))
                }
                pList.products = productLDBList
                realm?.add(pList)
                completion(pList.toDomian(),nil)
            })
            
        }catch {
            
            completion(nil,error.localizedDescription)
        }
    }
    
    func getProductDetails(id:String,_ completion:@escaping (_ sucess:ProductDetails?,_ failure:String?)->Void) {
        
        guard let result =  realm?.objects(ProductListLDB.self) else {
            
            completion(nil,"Can not fetch data")
            return
        }
        guard let products = result.first?.products else {
            
            completion(nil,"No Product List")
            return
        }
        guard let details = products.filter({$0._id.stringValue == id}).first else {
            
            completion(nil,"No Details")
            return
        }
        let productDetails = ProductDetails(id: details._id.stringValue, title:  details.title, description:  details.descriptions, price:  details.price, discountPercentage:  details.discountPercentage, rating:  details.rating, stock:  details.stock, brand:  details.brand, category:  details.category, thumbnail:  details.thumbnail, images:Array(details.images))
        completion(productDetails,nil)
    }

    
    func toggleFavorite(id:String,_ completion:@escaping (_ sucess:ProductList?,_ failure:String?)->Void) {
        
        guard let result =  realm?.objects(ProductListLDB.self) else{
            completion(nil,"Can not fetch data")
            return
        }
        
        guard let productList = result.first else {
            
            completion(nil,"No Product List")
            return
        }
        guard let details = productList.products.filter({$0._id.stringValue == id}).first else{
            completion(nil,"No Details")
            return
        }
        
        do {
            
            try realm?.write ({
                details.isFavourite.toggle()
                realm?.add(productList)
                completion(productList.toDomian(),nil)
            })
            
        } catch {
             
            completion(nil,error.localizedDescription)
        }
        
    }
}

