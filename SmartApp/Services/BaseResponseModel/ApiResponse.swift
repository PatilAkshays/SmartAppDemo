//
//  ApiResponse.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//



import Foundation
import ObjectMapper

open class BaseApiResponse: Mappable {
    var msg : String?
    var errCode : Int?
    var isSuccess : Bool?
    
    required public init?(){}
    
    required public init?(map: Map) {
        
    }
    
    public func mapping(map: Map) {
        msg <- map["status_message"]
        if msg != nil {
            isSuccess = false
        }else{
            isSuccess = true
        }
        errCode <- map["status_code"]
//        isSuccess <- map["success"]
    }

}
