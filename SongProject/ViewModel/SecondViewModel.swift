//
//  SecondViewModel.swift
//  SongProject
//
//  Created by Bartu on 26.02.2023.
//

import UIKit

class SecondViewModel {
  var dataChanges: ((Bool, Bool) -> Void)?

  var songs: [SongResults] = [] {
    didSet {
      self.dataChanges!(true, false)
    }
  }
  var resultNumber: String = ""


  var results: [SongResults] = []

  func songlistData(songs: [SongResults], resultNumber: String) {
    self.results = songs
    self.resultNumber = resultNumber
  }

}
