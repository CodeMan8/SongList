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

  var Allsongs: [SongResults] = []

  var activityView: UIActivityIndicatorView?

  var resultNumber: String = ""
  var resultCount: Int = 0

  var offset: Int = 0

  func fetchSongList() {
    ApiService.getResults { data in
       let json = try? JSONDecoder().decode(Song.self, from: data)
       self.Allsongs = json?.results ?? []
       self.resultCount = json?.resultCount ?? .zero
       self.resultNumber = "\(json?.resultCount ?? .zero) adet sonuç bulundu"
       self.dataChanges!(true, false)
    }
  }


  func fetchSongPage() {
    ApiService.getResultsWithParams(offset: offset, completion: { data in
      let json = try? JSONDecoder().decode(Song.self, from: data)
      print("songs")
      print(self.songs.count)
      print("offset")
      print(self.offset)
      self.songs.append(contentsOf: json?.results ?? [])
      self.dataChanges!(true, false)
    })
  }

  func increasePage() {
    self.offset = self.offset + 20
    fetchSongPage()
  }

  func isLastItem(row: Int)  -> Bool {
    return row == self.songs.count - 1
  }
}
