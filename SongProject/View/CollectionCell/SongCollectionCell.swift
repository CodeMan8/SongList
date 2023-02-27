  //
  //  SongCollectionCell.swift
  //  SongProject
  //
  //  Created by betbull on 25.02.2023.
  //

import UIKit
import Kingfisher

public class SongCollectionCell: UICollectionViewCell, ButtonActionDelegate {
  
  func applyButtonPressed(_ sender: UIButton) {
    self.delegate?.applyButtonPressed(sender)
  }
  
    //- MARK: Outlets
  @IBOutlet weak var removeButton: UIButton!
  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var profileView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var releaseLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!
  @IBOutlet weak var customButton: CustomButton!
  
  var removeCell: (() -> Void)?
  weak var delegate:ButtonActionDelegate?
  
  public override func awakeFromNib() {
    super.awakeFromNib()
    customButton.delegate = self
  }
  
  public override func layoutSubviews() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 3
  }

  public override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    setNeedsLayout()
    layoutIfNeeded()

    let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
    var frame = layoutAttributes.frame
    frame.size.height = ceil(size.height)
    layoutAttributes.frame = frame

    return layoutAttributes
  }
  
   func configure(delegate: ButtonActionDelegate,tag: Int, result: SongResults) {
    self.artistLabel.text = result.artistName
    self.trackLabel.text = result.trackName
    self.priceLabel.text = "\(result.collectionPrice ?? .zero)"
    self.releaseLabel.text = result.releaseDate
    self.removeButton.isHidden = false
    self.profileView.kf.setImage(with: URL(string: result.artworkUrl100)!)
    self.delegate = delegate
    customButton.tag = tag
  }
  
  //- MARK: Actions

  @IBAction func removeButtonDidPressed(_ sender: UIButton) {
    removeCell?()
  }
}
