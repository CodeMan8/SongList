  //
  //  SongCardCell.swift
  //  SongProject
  //
  //  Created by betbull on 26.02.2023.
  //

import UIKit

public class SongCardCell: UICollectionViewCell, ButtonActionDelegate {

  func applyButtonPressed(_ sender: UIButton) {
    self.delegate?.applyButtonPressed(sender)
  }

  //- MARK: Outlets

  @IBOutlet weak var customButton: CustomButton!
  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!

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
    artistLabel.text = result.artistName
    trackLabel.text = result.trackName
    self.delegate = delegate
    customButton.tag = tag
  }
}
