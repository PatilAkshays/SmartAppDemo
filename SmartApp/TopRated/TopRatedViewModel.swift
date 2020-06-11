//
//  TopRatedViewModel.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit

class TopRatedViewModel: NSObject {
   
    @IBOutlet var apiClient: ApiClient!
      
      var topRatedResponse : TopRatedResponse?

        func requestNowPlayingMovieList(completion: @escaping (TopRatedResponse) -> Void) {
            
            apiClient?.requestTopRatedMovieList(completionHandler: { (response) in
                DispatchQueue.main.async {
                    self.topRatedResponse = response
                    if self.isTopRatedMovieSuccess(){
                        
                    }else{
                        print(self.getTopRatedMovieSuccessMsg())
                    }
                    completion(self.topRatedResponse!)
                }
            })
        }
        
        func isTopRatedMovieSuccess() -> Bool {
            return (topRatedResponse?.isSuccess ?? false)
        }
        
        func getTopRatedMovieSuccessMsg() -> String {
            return (topRatedResponse?.msg) ?? "Unknown Error"
        }
        
      
}
