//
//  Result.swift
//  OnTheGo
//
//  Created by philips on 12/10/18.
//  Copyright © 2018 R. All rights reserved.
//

import Foundation

enum Result<T,U> where U: Error {
    case success(T)
    case failure(U)
}
