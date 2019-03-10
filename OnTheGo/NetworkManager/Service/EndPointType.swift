//
//  EndPointType.swift
//  OnTheGo
//
//  Created by Ratnadeep on 3/9/19.
//  Copyright © 2019 R. All rights reserved.
//

import Foundation

protocol EndPointType{
    var baseURL: URL {get}
    var path: String {get}
    var httpMethod: HTTPMethod{get}
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    
}
