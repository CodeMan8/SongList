  //
  //  Song.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit

public class Song: Codable {
  
  let resultCount: Int
  let results: [SongResults]
  
  required public init(from decoder :Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    results = try values.decode([SongResults].self, forKey: .results)
    resultCount = try values.decode(Int.self, forKey: .resultCount)
  }
  
  enum CodingKeys: String, CodingKey {
    case results = "results"
    case resultCount = "resultCount"
  }
}

public class SongResults: Codable {
  let trackName: String
  let artistName: String
  let artworkUrl100: String
  let collectionName: String?
  let collectionPrice: Double?
  let releaseDate: String?
  let trackId: Int?
  
  required public init(from decoder :Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)
    trackName = try values.decode(String.self, forKey: .trackName)
    artistName = try values.decode(String.self, forKey: .artistName)
    artworkUrl100 = try values.decode(String.self, forKey: .artworkUrl100)
    collectionName = try values.decodeIfPresent(String.self, forKey: .collectionName)
    collectionPrice = try values.decodeIfPresent(Double.self, forKey: .collectionPrice)
    releaseDate = try values.decode(String.self, forKey: .releaseDate)
    trackId = try values.decodeIfPresent(Int.self, forKey: .trackId)
  }
  
  enum CodingKeys: String, CodingKey {
    case trackName = "trackName"
    case artistName = "artistName"
    case artworkUrl100 = "artworkUrl100"
    case collectionName = "collectionName"
    case collectionPrice = "collectionPrice"
    case releaseDate = "releaseDate"
    case trackId = "trackId"
    
  }
}
