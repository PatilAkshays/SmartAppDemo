//
//  TopRatedResponse.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class TopRatedResponse: BaseApiResponse {
    var movieList = [MovieDetails]()
    
    override func mapping(map: Map) {
        movieList <- map["results"]
        msg <- map["status_message"]
        errCode <- map["status_code"]
        isSuccess = true
    }
}
