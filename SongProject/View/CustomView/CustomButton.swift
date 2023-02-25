//
//  CustomButton.swift
//  SongProject
//
//  Created by Bartu on 25.02.2023.
//

import UIKit

@IBDesignable
final class CustomButton: UIView {

  @IBAction func buttonPressed(_ sender: UIButton) {
    button.tag = self.tag
    self.delegate?.applyButtonPressed(sender)
  }

  @IBOutlet weak var button: UIButton!
  var delegate:ButtonActionDelegate?

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.configureView()
  }

  private func configureView() {
    guard let view = self.loadViewFromNib(nibName: "CustomButton") else { return }
    view.frame = self.bounds
    self.addSubview(view)
  }
}

protocol ButtonActionDelegate {
  func applyButtonPressed(_ sender:UIButton)
}
