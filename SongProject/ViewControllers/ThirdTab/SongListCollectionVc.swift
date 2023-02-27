  //
  //  SongListCollectionVc.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit

public class SongListCollectionVc: UIViewController, ButtonActionDelegate {
  
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var profileView: CustomProfileView!
  
  var viewModel = ThirdViewModel()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareCollectionView()
    viewModel.songs = viewModel.results
    self.navigationController?.navigationBar.isHidden = true
    NotificationCenter.default.addObserver(self, selector: #selector(self.removedItem), name: NSNotification.Name(rawValue: "removedItem"), object: nil)
    
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    hideNavigationBar()
    super.viewWillAppear(animated)
  }
  
  private func prepareCollectionView() {
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(UINib(nibName: Constants.Cell.collectionCellNib, bundle: nil), forCellWithReuseIdentifier: Constants.Cell.collectionCellNib)
    
  }
  
  public func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.songs[sender.tag]
    self.navigationController?.pushViewController(detailVc, animated: true)
  }
  
  private func  hideNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }
  
  private func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.collectionView.reloadData()
      }
    }
  }
  
  @objc public  func removedItem(notification: NSNotification) {
    if let results = notification.object as? SongResults {
      remove(with: results)
    }
  }
  
  private func remove(with item: SongResults) {
    if let index = self.viewModel.songs.firstIndex(where: {$0.trackId == item.trackId}) {
      self.viewModel.songs.remove(at: index)
      let indexPath = IndexPath(item: index, section: 0)
      self.collectionView.performBatchUpdates({
        self.collectionView.deleteItems(at: [indexPath])
      })
    }
  }
}

  // MARK: - CollectionView Delegate And Datasource Methods

extension SongListCollectionVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: SongCardCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.collectionCellNib, for: indexPath as IndexPath) as? SongCardCell else {
      fatalError("SongCardCell cell is not found")
    }
    
    let song = viewModel.getCellViewModel(at: indexPath)
    cell.configure(delegate: self, tag: indexPath.item, result: song)
    
    return cell
    
  }
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getNumberOfRows()
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let size = collectionView.frame.size.height
    return CGSize(width: viewModel.getCellWidth(view: self.collectionView), height: viewModel.getCellHeight(view: self.collectionView))
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
  }
  
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
}
