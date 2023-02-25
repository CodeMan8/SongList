//
//  SongViewModel.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

protocol SongViewModelProtocol {

  var dataChanges: ((Bool, Bool) -> Void)? { get set }

  func fetchSongList()
}

class SongViewModel: SongViewModelProtocol {

    //MARK: - Internal Propertiesd

  var dataChanges: ((Bool, Bool) -> Void)?

  var songs: [SongResults] = [] {
    didSet {
      self.dataChanges!(true, false)
    }
  }

  func fetchSongList() {
    ApiService.getResults { data in
      let json = try? JSONDecoder().decode(Song.self, from: data)
       self.songs = json?.results ?? []
    }
  }
}
