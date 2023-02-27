//
//  LastViewModel.swift
//  SongProject
//
//  Created by Bartu on 26.02.2023.
//

import UIKit

public class LastViewModel {

  public var dataChanges: ((Bool, Bool) -> Void)?

  public var songs: [SongResults] = []

  public var activityView: UIActivityIndicatorView?
  public weak var presentingView: EditableSongPresenting?


  public func updateData() {
    self.dataChanges!(true, false)
  }

  public func showActivityIndicator(view: UIView) {
    activityView = UIActivityIndicatorView(style: .large)
    activityView?.center = view.center
    view.addSubview(activityView!)
    activityView?.startAnimating()
  }

  public func hideActivityIndicator(){
    if (activityView != nil){
      activityView?.stopAnimating()
    }
  }

  public func showAlert(viewController: UIViewController, indexPath: IndexPath) {
    let alert = UIAlertController(title: nil, message: "Are you sure you'd like to delete this cell", preferredStyle: .alert)

    let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
      let removingSong =  self.songs.remove(at: indexPath.item)
      self.updateData()
      self.presentingView?.renderRemoveItem(indexPath: indexPath, song: removingSong)
      self.hideActivityIndicator()
    }
    alert.addAction(yesAction)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ _ in
      self.hideActivityIndicator()
    })
    viewController.present(alert, animated: true, completion: nil)
  }

  // MARK: collectionView helper methods

  public func getNumberOfRows() -> Int {
    return songs.count
  }

  public func getCellViewModel(at indexPath: IndexPath) -> SongResults {
    return songs[indexPath.item]
  }

  public func getCellWidth(view: UIView) -> CGFloat {
    return view.frame.size.width/1.5
  }

  public func getCellHeight(view: UIView) -> CGFloat {
    return view.frame.size.height/1.5
  }

}
  // MARK: - ViewModelPresenting

public protocol EditableSongPresenting: AnyObject {
  func renderRemoveItem(indexPath: IndexPath, song: SongResults)
}
