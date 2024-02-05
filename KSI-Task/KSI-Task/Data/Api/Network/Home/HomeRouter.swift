//
//  HomeRouter.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation
import Alamofire

enum HomeRouter:TargetType {
    
    case getProductList
    
    var queryies: [URLQueryItem]? {
        
        switch self{
            
        default:
            return nil
        }
    }
    
    var baseURL: String {
        
        switch self {
            
        default:
            return Constants.baseUrl.rawValue
        }
    }
    
    var path: String {
        
        switch self {
            
        case .getProductList:
            return "/products"
        }
    }
    
    var method:HTTPMethod {
        
        switch self {
        case .getProductList:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
            
        default:
            return nil
        }
    }
    
    var DataDic: Codable? {
        
        switch self {
            
        default:
            return nil
        }
    }
    
    var headers: [String : String]? {
        
        switch self {
            
        default:
            return nil
        }
    }
    
    
}
