//
//  APIException.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit

enum APIException: Error {
    case apiFailed(errMsg: String)
}

