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

extension String {
  func dateFormatted(from: String) -> Date? {
    let formatter = DateFormatter()
    formatter.locale = Locale(identifier: "en_US_POSIX")
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    let date = formatter.date(from: from)
    return date
  }

}

extension Date {
  func toString(withFormat format: String = "yyyy-MM-dd") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "TR")
    dateFormatter.dateFormat = format
    let str = dateFormatter.string(from: self)
    return str
  }
}
