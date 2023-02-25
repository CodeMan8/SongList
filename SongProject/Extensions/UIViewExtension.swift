//
//  UIViewExtension.swift
//  SongProject
//
//  Created by Bartu on 25.02.2023.
//

import UIKit
extension UIView {

  func loadViewFromNib(nibName: String) -> UIView? {
    let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self,options: nil).first as? UIView
  }

}
