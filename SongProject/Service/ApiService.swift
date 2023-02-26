//
//  ApiService.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit
import Alamofire


class Constants {
  static let API  = "https://itunes.apple.com/search?term=jack+johnson"
}

public typealias Callback<T> = (_: T) -> Void

class ApiService {

  static func getResults(completion: @escaping Callback<Data>) {

    AF.request(Constants.API)
      .response { response in
        completion(response.data!)
        if response.error != nil {
          print(response.error!)
        }
      }
  }

  static func getResultsWithParams(offset: Int, completion: @escaping Callback<Data>) {
    let params = ["offset": offset,"limit": 20] as [String : Any]

    AF.request(Constants.API,parameters: params)
      .response { response in
        completion(response.data!)
        if response.error != nil {
          print(response.error!)
        }
      }
  }

}
