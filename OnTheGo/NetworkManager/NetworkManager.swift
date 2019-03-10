//
//  NetworkManager.swift
//  OnTheGo
//
//  Created by philips on 12/10/18.
//  Copyright © 2018 R. All rights reserved.
//

import Foundation
enum NetworkResponse: String {
    case success
    case badRequest = "Bad request"
    case failed = "Network request failed"
    case noData = "Response returned with no data to decode"
    case unableToDecode = "We could not decode the response"
}

enum Result<String> {
    case success
    case failure(String)
}
struct NetworkManager {
    
    static let environment : NetworkEnvironment = .production
    
    let router = Router<OnTheGoAPI>()
    
    func loginAPI(mobileNumber: String, completion:@escaping(_ data:[String: Any]?, _ error:String?)->()) {
        
        print("mobile name \(mobileNumber)")
        router.request(.login(["mobile":mobileNumber])) { (data, response, error) in
            if error != nil {
                completion(nil,"No Network")
                return
            }
            
            if let response = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(response)
                
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData  = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                        completion(jsonData as? [String : Any],nil)
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        
        }
        
    }
    
    func otpVerificationAPI(_ parameters: [String: String], completion:@escaping(_ data:[String:Any]?, _ error:String?)->()) {
        router.request(.otpVerification(parameters)) { (data, response, error) in
            
            if error != nil {
                completion(nil,"No Network")
                return
            }
            if let respone = response as? HTTPURLResponse {
                let result = self.handleNetworkResponse(respone)
                switch result {
                case .success:
                    guard let responseData = data else {
                        completion(nil, NetworkResponse.noData.rawValue)
                        return
                    }
                    do {
                        let jsonData  = try JSONSerialization.jsonObject(with: responseData, options: .allowFragments)
                        
                        completion(jsonData as? [String : Any],nil)
                        
                    }catch {
                        print(error)
                        completion(nil, NetworkResponse.unableToDecode.rawValue)
                    }
                case .failure(let networkFailureError):
                    completion(nil, networkFailureError)
                }
            }
        }
    }
    
    fileprivate func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<String>{
        switch response.statusCode {
        case 200...299: return .success
        case 501...599: return .failure(NetworkResponse.badRequest.rawValue)
        default: return .failure(NetworkResponse.failed.rawValue)
        }
    }
}
