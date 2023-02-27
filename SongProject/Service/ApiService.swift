  //
  //  ApiService.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit
import Alamofire

public typealias Callback<T> = (_: T) -> Void

class ApiService {

  static func getResults(completion: @escaping Callback<Data>) {

    AF.request(Constants.API)
      .response { response in

        switch response.result {
        case .failure(let error) :
          print(error)

        case .success(let value) :
          completion(value!)
        }
      }
  }

  static func getResultsWithParams(offset: Int, completion: @escaping Callback<Data>) {
    let params = ["offset": offset,"limit": 20] as [String : Any]

    AF.request(Constants.API,parameters: params)
      .response { response in

        switch response.result {
        case .failure(let error) :
          print(error)

        case .success(let value) :
          completion(value!)
        }
      }
  }

}
