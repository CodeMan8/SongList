//
//  ThirdViewModel.swift
//  SongProject
//
//  Created by Bartu on 26.02.2023.
//

import UIKit

class ThirdViewModel {

  var dataChanges: ((Bool, Bool) -> Void)?

  var songs: [SongResults] = [] {
    didSet {
      self.dataChanges!(true, false)
    }
  }

  var results: [SongResults] = []

  func songlistData(songs: [SongResults]) {
    self.results = songs
  }

}
