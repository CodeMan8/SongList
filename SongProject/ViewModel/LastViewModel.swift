//
//  LastViewModel.swift
//  SongProject
//
//  Created by Bartu on 26.02.2023.
//

import UIKit

class LastViewModel {

  var dataChanges: ((Bool, Bool) -> Void)?

  var songs: [SongResults] = []

  var activityView: UIActivityIndicatorView?

  func updateData() {
    self.dataChanges!(true, false)
  }

  

  func showActivityIndicator(view: UIView) {
    activityView = UIActivityIndicatorView(style: .large)
    activityView?.center = view.center
    view.addSubview(activityView!)
    activityView?.startAnimating()
  }

  func hideActivityIndicator(){
    if (activityView != nil){
      activityView?.stopAnimating()
    }
  }

}
