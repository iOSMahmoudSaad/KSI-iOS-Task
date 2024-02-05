//
//  TargetProtocol.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//

import Foundation
import Alamofire

protocol TargetType:URLRequestConvertible {
    
    var queryies:[URLQueryItem]? {get}
    var baseURL: String {get}
    var path: String {get}
    var method: HTTPMethod {get}
    var parameters: Parameters? {get}
    var DataDic:Codable? {get}
    var headers: [String: String]? {get}
}
extension TargetType{
    
    func createStringUrl() -> String {
        
        switch self {
            
        default:
            
            let string              = baseURL + path
            let endPointwithquery   = string.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
            let endPoint            = endPointwithquery?.replacingOccurrences(of:  "%5B%5D=", with: "=") ?? ""
            return endPoint
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        
        var urlComponents = URLComponents(string: baseURL + path)!
        urlComponents.queryItems = queryies
        var urlRequest = URLRequest(url:  urlComponents.url!)
        print("Request URL: ", urlComponents.url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        print("Request Headers: ", urlRequest.allHTTPHeaderFields)
        print("Request Method: ", urlRequest.method)
        if let parameters = parameters {
            
            print("Request Body: ", parameters)
            do {
                
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                print(String(data: urlRequest.httpBody!, encoding: .utf32))
            } catch (let error) {
                
                print(error)
            }
        }
        if let DataDic {
            
            do {
                
                urlRequest.httpBody = try JSONEncoder().encode(DataDic)
                print(String(data: urlRequest.httpBody!, encoding: .utf32))
            } catch (let error) {
                
                print(error)
            }
        }
        
        return urlRequest
    }
    
}

