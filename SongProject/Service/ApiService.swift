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
        completion(response.data!)
        let json = try? JSONDecoder().decode(Song.self, from: response.data!)
        let veri = json?.results
        if response.error != nil {
          print(response.error!)
        }
      }
  }

}

class Constants {
  static let API  = "https://itunes.apple.com/search?term=jack+johnson"
}
