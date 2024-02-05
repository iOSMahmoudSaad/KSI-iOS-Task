//
//  FavouriteProductItemUseCase.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation

import Foundation
protocol FavouriteProductItemUseCase {
    func excute(id:String,_ completion:@escaping(_ success:ProductList?,_ error:String?) ->Void)
}
 
class DefaultProductItemFavUsecase:FavouriteProductItemUseCase{
    
    

   private let repo:HomeRepo
    
    init(homeRepo: HomeRepo) {
        self.repo = homeRepo
    }
    func excute(id:String,_ completion:@escaping(_ success:ProductList?,_ error:String?) ->Void){
        repo.addFaveorite(id: id, completion)
    }
}
