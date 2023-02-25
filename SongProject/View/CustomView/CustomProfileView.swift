//
//  CustomProfileView.swift
//  SongProject
//
//  Created by Bartu on 25.02.2023.
//

import UIKit

@IBDesignable
final class CustomProfileView: UIView {

  @IBOutlet weak var profileView: UIImageView!

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.configureView()
  }

  private func configureView() {
    guard let view = self.loadViewFromNib(nibName: "CustomProfileView") else { return }
    view.frame = self.bounds
    self.addSubview(view)
  }


}
