//
//  RequestClient.swift
//  KSI-Task
//
//  Created by Mahmoud Saad on 05/02/2024.
//



import Alamofire
import UIKit

class CustomInterceptor:RequestInterceptor {
    
    private let retryLimit = 3
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        
        if let statusCode = request.response?.statusCode
            ,statusCode == 401,request.retryCount < retryLimit {}
        else {
            
            completion(.doNotRetry)
        }
    }

}

class BaseClient {
    
    @discardableResult
    static func `performRequest`<T:Decodable,E:Decodable>(route:URLRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion:  @escaping (_ sucess: T?,_ failure: E?,_ error: Error?)->Void) -> DataRequest {
        
        return AF.request(route,
                          interceptor: CustomInterceptor()).validate(statusCode: 200..<300)
        
            .responseDecodable (decoder: decoder){ (response: DataResponse<T,AFError>) in
                print("Status Code:",response.response?.statusCode as Any)
                switch response.result {
                    
                case.success(_):
                    if response.response?.statusCode == 204 {
                        
                        completion(nil, nil,nil)
                    } else {
                        
                        do {
                            
                            guard let data = response.data else{return}
                            print("DATA: ",String(data: data, encoding: .utf8) ?? "")
                            let dataJson = try decoder.decode(T.self, from: data)
                            completion(dataJson,nil,nil)
                        } catch let error {
                            
                            completion(nil, nil,error)
                        }
                    }
                case .failure(let error):
                    
                    if response.response?.statusCode == 400 ||  response.response?.statusCode == 422 {
                        
                        do {
                            
                            guard let data = response.data else{return}
                            print(String(data: data, encoding: .utf8) ?? "")
                            let dataJson = try decoder.decode(E.self, from: data)
                            completion(nil,dataJson,nil)
                        } catch let error {
                            
                            
                            completion(nil, nil,error)
                        }
                    } else {
                        
                        print("Error--------",error)
                        print(response.request?.url as Any)
                        completion(nil,nil,error)
                    }
                }
            }
    }
    @discardableResult
    static func `uploadRequest`<T:Decodable,E:Decodable>(multiPart:MultipartFormData,route:URLRequestConvertible, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (_ sucess: T?,_ failure: E?,_ error: Error?)->Void) -> DataRequest {
        
        return AF.upload(multipartFormData: multiPart, with: route)
            .validate(statusCode: 200..<300)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T,AFError>) in
                switch response.result {
                    
                case.success(_):
                    do {
                        
                        guard let data = response.data else{return}
                        print("DATA: ",String(data: data, encoding: .utf8) ?? "")
                        let dataJson = try decoder.decode(T.self, from: data)
                        completion(dataJson,nil,nil)
                    } catch let error {
                        
                        completion(nil, nil,error)
                    }
                    
                case .failure(let error):
                  
                    if response.response?.statusCode == 400 {
                        
                        do {
                            
                            guard let data = response.data else{return}
                            print(String(data: data, encoding: .utf8) ?? "")
                            let dataJson = try decoder.decode(E.self, from: data)
                            completion(nil,dataJson,nil)
                            
                        } catch let error {
                            
                            completion(nil, nil,error)
                        }
                        
                    } else {
                        
                        completion(nil,nil,error)
                    }
                }
            }
    }
}
