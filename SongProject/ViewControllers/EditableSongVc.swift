//
//  EditableSongVc.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

class EditableSongVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var profileView: CustomProfileView!
  @IBOutlet weak var collectionView: UICollectionView!

  var viewModel = LastViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareCollectionView()
    hideNavigationBar()
  }

  func prepareCollectionView() {
    self.view.backgroundColor = .white
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(UINib(nibName: "SongCollectionCell", bundle: nil), forCellWithReuseIdentifier: "SongCell")
  }

  func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.songs[sender.tag]
    self.navigationController?.pushViewController(detailVc, animated: true)
  }

  private func hideNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }

  private func sendUpdateOtherViews(with indexPath: IndexPath) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removedItem"), object: indexPath)
  }

  private func removeSelectedItem(indexPath: IndexPath) {

    let alert = UIAlertController(title: nil, message: "Are you sure you'd like to delete this cell", preferredStyle: .alert)

    let yesAction = UIAlertAction(title: "Yes", style: .default) { _ in
      if self.viewModel.songs.count == indexPath.item {

      } else {
      }
      self.viewModel.songs.remove(at: indexPath.item)
      self.viewModel.updateData()
      self.collectionView.performBatchUpdates({
        self.collectionView.deleteItems(at: [indexPath])
      })
      self.sendUpdateOtherViews(with: indexPath)
      self.viewModel.hideActivityIndicator()
    }
    alert.addAction(yesAction)
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel){ _ in
      self.viewModel.hideActivityIndicator()
    })
    present(alert, animated: true, completion: nil)
  }

  func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.collectionView.reloadData()
      }
    }
  }


}

  // MARK: - UITableView Delegate And Datasource Methods
extension EditableSongVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: SongCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCell", for: indexPath as IndexPath) as? SongCollectionCell else {
      fatalError("SongCell cell is not found")
    }
    cell.removeCell = { [weak self] in
      guard let self = self else { return }
      self.removeSelectedItem(indexPath: indexPath)
      self.viewModel.showActivityIndicator(view: self.view)
    }

    let song = viewModel.songs[indexPath.row]
    cell.artistLabel.text = song.artistName
    cell.trackLabel.text = song.trackName
    cell.priceLabel.text = "\(song.collectionPrice ?? .zero)"
    cell.releaseLabel.text = song.releaseDate
    cell.removeButton.isHidden = false
    cell.profileView?.image = try? UIImage(data: Data(contentsOf: URL(string: song.artworkUrl100)!))
    cell.configure(delegate: self, tag: indexPath.row)

    return cell

  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.songs.count
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: self.collectionView.frame.size.width/2 - 5, height: collectionView.frame.size.height - 50)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
}
