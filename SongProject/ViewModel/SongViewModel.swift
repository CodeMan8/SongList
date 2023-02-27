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

public class SongViewModel: SongViewModelProtocol {

    //MARK: - Properties

  public var dataChanges: ((Bool, Bool) -> Void)?

  public var firstPageResults: [SongResults] = [] {
    didSet {
      self.dataChanges!(true, false)
    }
  }

  public var otherResults: [SongResults] = []{
    didSet {
      self.dataChanges!(true, false)
    }
  }

  public var activityView: UIActivityIndicatorView?
  public var resultNumber: String = ""
  public var resultCount: Int = 0
  public var offset: Int = 0

  public func fetchSongList() {
    ApiService.getResults { [weak self] data in
       guard let self = self else { return }
       let json = try? JSONDecoder().decode(Song.self, from: data)
       self.otherResults = json?.results ?? []
       self.resultCount = json?.resultCount ?? .zero
       self.resultNumber = "\(json?.resultCount ?? .zero) adet sonuç bulundu"
    }
  }

  public func fetchSongPage() {
    ApiService.getResultsWithParams(offset: offset, completion: { [weak self] data in
      guard let self = self else { return }
      let json = try? JSONDecoder().decode(Song.self, from: data)
      self.firstPageResults.append(contentsOf: json?.results ?? [])
    })
  }

  public func increasePage() {
    self.offset = self.offset + 20
    fetchSongPage()
  }

  public func isLastItem(row: Int)  -> Bool {
    return row == self.firstPageResults.count - 1
  }

  public func getNumberOfRows() -> Int {
    return firstPageResults.count
  }

  public func getCellViewModel(at indexPath: IndexPath) -> SongResults {
    return firstPageResults[indexPath.row]
  }

}
