//
//  SongCollectionCell.swift
//  SongProject
//
//  Created by betbull on 25.02.2023.
//

import UIKit

class SongCollectionCell: UICollectionViewCell, ButtonActionDelegate {
  func applyButtonPressed(_ sender: UIButton) {
    self.delegate?.applyButtonPressed(sender)
  }

  @IBOutlet weak var removeButton: UIButton!

  @IBOutlet weak var trackLabel: UILabel!
  @IBOutlet weak var profileView: UIImageView!
  @IBOutlet weak var priceLabel: UILabel!
  @IBOutlet weak var releaseLabel: UILabel!
  @IBOutlet weak var artistLabel: UILabel!

  @IBOutlet weak var customButton: CustomButton!

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
    let targetSize = CGSize(width: layoutAttributes.frame.width, height: 0)
    layoutAttributes.frame.size = contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    return layoutAttributes
  }

  public func configure(delegate: ButtonActionDelegate,tag: Int) {
    self.delegate = delegate
    customButton.tag = tag
  }

  @IBAction func removeButtonDidPressed(_ sender: UIButton) {

  }
}
