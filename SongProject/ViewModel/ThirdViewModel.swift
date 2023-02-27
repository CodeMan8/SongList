//
//  ThirdViewModel.swift
//  SongProject
//
//  Created by Bartu on 26.02.2023.
//

import UIKit

class ThirdViewModel {

  public var dataChanges: ((Bool, Bool) -> Void)?

  public var songs: [SongResults] = [] {
    didSet {
      self.dataChanges!(true, false)
    }
  }

  public var results: [SongResults] = []

  public func songlistData(songs: [SongResults]) {
    self.results = songs
  }

  // MARK: collectionView helper methods

  public func getNumberOfRows() -> Int {
    return songs.count
  }

  public func getCellViewModel(at indexPath: IndexPath) -> SongResults {
    return songs[indexPath.item]
  }

  public func getCellWidth(view: UIView) -> CGFloat {
    return view.frame.size.width/2 - 5
  }

  public func getCellHeight(view: UIView) -> CGFloat {
    return view.frame.size.height/2 - 50
  }

}
