//
//  OnTheGoEndPoint.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/10/19.
//  Copyright © 2019 R. All rights reserved.
//

import Foundation

enum NetworkEnvironment {
    case production
}
public enum OnTheGoAPI {
    case login(_ parameter: [String: String])
    
}

extension OnTheGoAPI: EndPointType {
    
    var enviromentBaseURL: String {
        switch  NetworkManager.environment {
        case .production:
            return "http://3.18.115.109/workondemand"
        }
    }
    var baseURL: URL {
        guard let url =  URL(string: enviromentBaseURL) else {fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .login:
            return "index.php/v1/login"
        }
    }
    
    var httpMethod: HTTPMethod {
        switch self {
        case .login(_):
            return .post
        }
    }
    
    var task: HTTPTask {
        switch self {
        case .login(let parameters):
            print(parameters)
            return .requestParameters(bodyParameters: parameters, bodyEncoding: .jsonEncoding, urlParameters: nil)
        }
    }
    
    var headers: HTTPHeaders? {
       return nil
    }
    
}
