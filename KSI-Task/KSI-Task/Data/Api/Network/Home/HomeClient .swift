//
//  Home Client .swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation

import Foundation
import Alamofire

class HomeClient:BaseClient {
    
    static func getProductList(_ completionHandler:@escaping (_ sucess: ProductListDTO?,_ failure: String?,_ error: Error?)->Void) {
        
        performRequest(route: HomeRouter.getProductList, completion: completionHandler)
    }
}
