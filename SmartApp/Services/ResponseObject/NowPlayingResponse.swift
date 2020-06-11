//
//  NowPlayingResponse.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper

class NowPlayingResponse: BaseApiResponse {

    var movieList = [MovieDetails]()
      
    override func mapping(map: Map) {
        movieList <- map["results"]
        msg <- map["status_message"]
        errCode <- map["status_code"]
        isSuccess = true
    }
    
      
}


class MovieDetails: Mappable {
    var poster_path: String?
    var backdrop_path: String?
    var original_title: String?
    var title: String?
    var overview: String?
    var release_date: String?
    var vote_average:  Float = 0
    var popularity: Float = 0

    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        overview <- map["overview"]
        poster_path <- map["poster_path"]
        backdrop_path <- map["backdrop_path"]
        original_title <- map["original_title"]
        title <- map["title"]
        release_date <- map["release_date"]
        vote_average <- map["vote_average"]
        popularity <- map["popularity"]
    }
}
