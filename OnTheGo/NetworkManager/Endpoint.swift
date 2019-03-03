//
//  Endpoint.swift
//  OnTheGo
//
//  Created by philips on 12/10/18.
//  Copyright © 2018 R. All rights reserved.
//

import Foundation
protocol  Endpoint {
    var base : String {get}
    var path : String {get}
}

extension Endpoint {
    var urlComponents: URLComponents {
        
        var components = URLComponents(string: base)!
        components.path = path

        return components
    }
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum OnTheGoURL {
    case sendOTP
    case otpVerify
    case userprofile
}

extension OnTheGoURL: Endpoint {
    var base: String  {
        return  "https://49jdqasn24.execute-api.ap-south-1.amazonaws.com"
    }
    var path: String {
        switch self {
        case .sendOTP: return "/v1/otpsend"
        case .otpVerify: return "/v1/otpverify"
        case .userprofile: return "/v1/userprofile"
        }
    }
}
