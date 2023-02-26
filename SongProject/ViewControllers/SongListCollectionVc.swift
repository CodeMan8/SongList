//
//  SongListCollectionVc.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

class SongListCollectionVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var profileView: CustomProfileView!

  var viewModel = ThirdViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareCollectionView()
    hideNavigationBar()
    viewModel.songs = viewModel.results
    self.navigationController?.navigationBar.isHidden = true
    NotificationCenter.default.addObserver(self, selector: #selector(self.removedItem), name: NSNotification.Name(rawValue: "removedItem"), object: nil)

  }

  func prepareCollectionView() {
    self.view.backgroundColor = .white
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(UINib(nibName: "SongCardCell", bundle: nil), forCellWithReuseIdentifier: "SongCardCell")

  }

  func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.songs[sender.tag]
    self.navigationController?.pushViewController(detailVc, animated: true)
  }

  private func  hideNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }

  func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.collectionView.reloadData()
      }
    }
  }

  @objc public  func removedItem(notification: NSNotification) {
    if let indexPath = notification.object as? IndexPath {
      remove(with: indexPath)
    }
  }

  private func remove(with indexPath: IndexPath) {
    self.viewModel.songs.remove(at: indexPath.item)
    self.collectionView.performBatchUpdates({
      self.collectionView.deleteItems(at: [indexPath])
    })
  }
}

  // MARK: - UITableView Delegate And Datasource Methods
extension SongListCollectionVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: SongCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SongCardCell", for: indexPath as IndexPath) as? SongCardCell else {
      fatalError("SongCardCell cell is not found")
    }

    let song = viewModel.songs[indexPath.row]
    
    cell.artistLabel.text = song.artistName
    cell.trackLabel.text = song.trackName
    cell.configure(delegate: self, tag: indexPath.row)

    return cell

  }
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.songs.count
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = collectionView.frame.size.height
    return CGSize(width: self.collectionView.frame.size.width/2 - 5, height: size / 2 - 50)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
}
