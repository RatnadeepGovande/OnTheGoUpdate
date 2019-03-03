//
//  NetworkManager.swift
//  OnTheGo
//
//  Created by philips on 12/10/18.
//  Copyright © 2018 R. All rights reserved.
//

import Foundation

class NetworkManager {
    static let shareInstant = NetworkManager()
    private init () {
        
    }
    
    
    func postrequest(_ requestType: OnTheGoURL, parameter: [String: String], complitionHanlder: @escaping ([String:String]?, Error?) -> Void) {
        let endpoint = requestType
        var request =  endpoint.request
        request.httpMethod = "POST"
        
        guard let  data = self.requestedParameter(parameter) else {
            return print("not data")
        }
        request.httpBody = data
        let urlSession  =  URLSession.init(configuration: .default)

        let task =   urlSession.dataTask(with: request) { (data1, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }else {
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data1!, options: .mutableLeaves)
                    complitionHanlder(jsonData as? [String : String], nil)
                }catch {
                    print("Data error : \(error.localizedDescription)")
                }
            }
        }
        task.resume()
        
    }
    
    func requestedParameter(_ parameter: [String: String]) -> Data? {
        do {
            let data = try JSONSerialization.data(withJSONObject: parameter, options: .prettyPrinted)
            return data
        }catch {
            print("\(error.localizedDescription)")
        }
        return nil
    }
    
}
