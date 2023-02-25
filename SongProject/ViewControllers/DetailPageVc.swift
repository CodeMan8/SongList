//
//  DetailPageVc.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

class DetailPageVc: UIViewController {

  /// MARK - Outlets
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var albumLabel: UILabel!
  @IBOutlet weak var photoView: UIImageView!
  @IBOutlet weak var songLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!

  public var song: SongResults?

  override func viewDidLoad() {
    super.viewDidLoad()
    guard let song = song else { return }
    configure(with: song)
    self.navigationController?.navigationBar.isHidden = false

  }

  private func configure(with song: SongResults)  {
    if let  price = song.collectionPrice {
      priceLabel.text = "price \(price)$"
    }
    else {
      priceLabel.text = "no price"
    }
    nameLabel.text = song.artistName
    albumLabel.text = song.collectionName
    photoView.image = try? UIImage(data: Data(contentsOf: URL(string: song.artworkUrl100)!))
    songLabel.text = song.trackName
    dateLabel.text = song.releaseDate
  }

}
