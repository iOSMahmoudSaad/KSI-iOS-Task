//
//  HomeRepo.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation

import Foundation

protocol HomeRepo {
    func getProductList( _ completion:@escaping(_ success:ProductList?,_ error:String?) ->Void)
    func addFaveorite(id:String,_ completion:@escaping(_ success:ProductList?,_ error:String?) ->Void)
}
