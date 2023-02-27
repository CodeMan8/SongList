//
//  SecondViewModel.swift
//  SongProject
//
//  Created by Bartu on 26.02.2023.
//

import UIKit

public class SecondViewModel {
  var dataChanges: ((Bool, Bool) -> Void)?

  public var songs: [SongResults] = [] {
    didSet {
      self.dataChanges!(true, false)
      updateResultNumberText()
    }
  }

  public var resultNumberText: String = ""
  public var results: [SongResults] = []

  public func songlistData(songs: [SongResults]) {
    self.results = songs
  }

  public func updateResultNumberText() {
    self.resultNumberText = "\(self.songs.count) adet sonuç bulundu"
  }

  public func getNumberOfRows() -> Int {
    return songs.count
  }

  public func getCellViewModel(at indexPath: IndexPath) -> SongResults {
    return songs[indexPath.row]
  }
}
