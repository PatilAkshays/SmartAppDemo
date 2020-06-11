//
//  ApiClient.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//


import UIKit
import Alamofire
import AlamofireObjectMapper

class ApiClient: NSObject {
  
        private let baseUrl = "https://api.themoviedb.org/3/movie"

    
    func requestNowPlayingMovieList(completionHandler: @escaping (NowPlayingResponse) -> Void ) {

           let url = "\(baseUrl)/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"

           let headers: HTTPHeaders = [
               "Accept": "application/json",
               "Content-Type": "application/json"
           ]

           UIApplication.shared.isNetworkActivityIndicatorVisible = true

           Alamofire.request(url, method:.get, encoding: JSONEncoding.default, headers: headers).responseObject(completionHandler: { (response: DataResponse< NowPlayingResponse >) in
               UIApplication.shared.isNetworkActivityIndicatorVisible = false
               switch(response.result){
               case .success:
                   completionHandler(response.result.value!)
               case .failure(let error):
                   print("Error ",error)
                   let apiErrorResponse = NowPlayingResponse()
                   apiErrorResponse?.isSuccess = false
                   apiErrorResponse?.msg = "Something went wrong!"
                   completionHandler(apiErrorResponse!)
               }
           })
       }
    
    
    func requestTopRatedMovieList(completionHandler: @escaping (TopRatedResponse) -> Void ) {
        let url = "\(baseUrl)/top_rated?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        Alamofire.request(url, method:.get, encoding: JSONEncoding.default, headers: headers).responseObject(completionHandler: { (response: DataResponse<TopRatedResponse>) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            switch(response.result){
            case .success:
                completionHandler(response.result.value!)
            case .failure(let error):
                print("Error ",error)
                let apiErrorResponse = TopRatedResponse()
                apiErrorResponse?.isSuccess = false
                apiErrorResponse?.msg = "Something went wrong!"
                completionHandler(apiErrorResponse!)
            }
        })
    }
    
    
}
