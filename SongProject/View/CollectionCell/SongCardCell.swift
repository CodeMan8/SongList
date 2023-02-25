//
//  SongCardCell.swift
//  SongProject
//
//  Created by betbull on 26.02.2023.
//

import UIKit

class SongCardCell: UICollectionViewCell, ButtonActionDelegate {

  @IBOutlet weak var customButton: CustomButton!
  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!

  func applyButtonPressed(_ sender: UIButton) {
      self.delegate?.applyButtonPressed(sender)
  }

  var delegate:ButtonActionDelegate?

  override func awakeFromNib() {
    super.awakeFromNib()
    customButton.delegate = self
  }

  override func layoutSubviews() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 3
  }

  override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    setNeedsLayout()
    layoutIfNeeded()

    let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)

    var frame = layoutAttributes.frame
    frame.size.height = ceil(size.height)

    layoutAttributes.frame = frame

    return layoutAttributes
  }

  public func configure(delegate: ButtonActionDelegate,tag: Int) {
    self.delegate = delegate
    customButton.tag = tag
  }



}
