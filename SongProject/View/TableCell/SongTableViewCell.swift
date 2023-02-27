  //
  //  SongTableViewCell.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit
import Kingfisher

public class SongTableViewCell: UITableViewCell, ButtonActionDelegate {

  public func applyButtonPressed(_ sender: UIButton) {
    self.delegate?.applyButtonPressed(sender)
  }

  //- MARK: Outlets
  
  @IBOutlet weak var buttonView: CustomButton!
  @IBOutlet weak var secondaryLabel: UILabel!
  @IBOutlet weak var primaryLabel: UILabel!
  @IBOutlet weak var photoView: UIImageView!

  weak var delegate:ButtonActionDelegate?

  public override func layoutSubviews() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 3

  }

  public override func awakeFromNib() {
    super.awakeFromNib()
    buttonView.delegate = self
      // Initialization code
  }

   func configure(delegate: ButtonActionDelegate,tag: Int, result: SongResults) {
    primaryLabel.text = result.artistName
    secondaryLabel.text = result.trackName
    photoView.kf.setImage(with: URL(string: result.artworkUrl100)!)

    self.delegate = delegate
    buttonView.tag = tag
  }

  public func hidePhotoView() {
    self.photoView.isHidden = true
  }
}
