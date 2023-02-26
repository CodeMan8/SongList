//
//  SongTableViewCell.swift
//  SongProject
//
//  Created by betbull on 24.02.2023.
//

import UIKit

class SongTableViewCell: UITableViewCell, ButtonActionDelegate {

  @IBOutlet weak var buttonView: CustomButton!
  @IBOutlet weak var secondaryLabel: UILabel!
  @IBOutlet weak var primaryLabel: UILabel!
  @IBOutlet weak var photoView: UIImageView!

  var delegate:ButtonActionDelegate?

  override func layoutSubviews() {
    self.layer.borderColor = UIColor.black.cgColor
    self.layer.borderWidth = 3

  }
  override func awakeFromNib() {
    super.awakeFromNib()
    buttonView.delegate = self
        // Initialization code
    }
  public func configure(delegate: ButtonActionDelegate,tag: Int) {
    self.delegate = delegate
    buttonView.tag = tag
  }

  func applyButtonPressed(_ sender: UIButton) {

    self.delegate?.applyButtonPressed(sender)

  }
}
