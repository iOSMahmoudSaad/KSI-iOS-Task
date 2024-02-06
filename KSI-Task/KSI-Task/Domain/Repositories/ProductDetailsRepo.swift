//
//  ProductDetailsRepo.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 06/02/2024.
//

import Foundation

protocol ProductDetailsRepo {
    func getProducDetails(id:String, _ completion:@escaping(_ success:ProductDetails?,_ error:String?) ->Void)
    
}
