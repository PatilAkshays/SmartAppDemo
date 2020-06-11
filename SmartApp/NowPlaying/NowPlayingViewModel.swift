//
//  NowPlayingViewModel.swift
//  SmartApp
//
//  Created by Akshay Patil on 11/06/20.
//  Copyright © 2020 Treel. All rights reserved.
//

import UIKit

class NowPlayingViewModel: NSObject {
    @IBOutlet var apiClient: ApiClient!
    
    var nowPlayingResponse : NowPlayingResponse?

      func requestNowPlayingMovieList(completion: @escaping (NowPlayingResponse) -> Void) {
          apiClient?.requestNowPlayingMovieList(completionHandler: { (response) in
              DispatchQueue.main.async {
                  self.nowPlayingResponse = response
                  if self.isNowPlayingMovieSuccess(){
                      
                  }else{
                      print(self.getNowPlayingMovieSuccessMsg())
                  }
                  completion(self.nowPlayingResponse!)
              }
          })
      }
      
      func isNowPlayingMovieSuccess() -> Bool {
          return (nowPlayingResponse?.isSuccess ?? false)
      }
      
      func getNowPlayingMovieSuccessMsg() -> String {
          return (nowPlayingResponse?.msg) ?? "Unknown Error"
      }
      
    

}
