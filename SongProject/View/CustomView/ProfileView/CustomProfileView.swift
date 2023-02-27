//
//  CustomProfileView.swift
//  SongProject
//
//  Created by Bartu on 25.02.2023.
//

import UIKit

@IBDesignable
final class CustomProfileView: UIView, UITextFieldDelegate {

  @IBOutlet weak var profileView: UIImageView!
  @IBOutlet weak var textField: UITextField!
  @IBAction func textFieldDidEdit(_ sender: UITextField) {}

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.configureView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)
    self.configureView()
  }

  override func willMove(toSuperview newSuperview: UIView?) {
    textField.delegate = self
    NotificationCenter.default.addObserver(self, selector: #selector(self.updateProfileName), name: NSNotification.Name(rawValue: "ProfileNameChanged"), object: nil)

    super.willMove(toSuperview: newSuperview)

  }

  private func configureView() {
    guard let view = self.loadViewFromNib(nibName: "CustomProfileView") else { return }
    view.frame = self.bounds
    self.addSubview(view)
  }

  func textFieldDidEndEditing(_ textField: UITextField) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ProfileNameChanged"), object: textField.text)
  }

  @objc public  func updateProfileName(notification: NSNotification) {
    if let name = notification.object as? String {
      textField.text = name
    }
  }

}
