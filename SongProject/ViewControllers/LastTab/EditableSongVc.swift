  //
  //  EditableSongVc.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit

public class EditableSongVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var profileView: CustomProfileView!
  @IBOutlet weak var collectionView: UICollectionView!

  var viewModel = LastViewModel()

  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareCollectionView()
    viewModel.presentingView = self
  }

  public override func viewWillAppear(_ animated: Bool) {
    hideNavigationBar()
    super.viewWillAppear(animated)
  }

  private func hideNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }

  private func prepareCollectionView() {
    self.collectionView.delegate = self
    self.collectionView.dataSource = self
    self.collectionView.register(UINib(nibName: Constants.Cell.collectionCellReuse, bundle: nil), forCellWithReuseIdentifier: Constants.Cell.cellReuse)
  }

  private func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.collectionView.reloadData()
      }
    }
  }

  public func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.songs[sender.tag]
    self.navigationController?.pushViewController(detailVc, animated: true)
  }


  private func sendUpdateOtherViews(with results: SongResults) {
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "removedItem"), object: results)
  }

  private func removeSelectedItem(indexPath: IndexPath) {
    viewModel.showAlert(viewController: self, indexPath: indexPath)
  }

}

  // MARK: - CollectionView Delegate And Datasource Methods

extension EditableSongVc: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell: SongCollectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Cell.cellReuse, for: indexPath as IndexPath) as? SongCollectionCell else {
      fatalError("SongCell cell is not found")
    }
    cell.removeCell = { [weak self] in
      guard let self = self else { return }
      self.removeSelectedItem(indexPath: indexPath)
      self.viewModel.showActivityIndicator(view: self.view)
    }

    let song = viewModel.getCellViewModel(at: indexPath)
    cell.configure(delegate: self, tag: indexPath.item, result: song)

    return cell

  }
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.getNumberOfRows()
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    return CGSize(width: viewModel.getCellWidth(view: self.collectionView), height: viewModel.getCellHeight(view: self.collectionView))
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 0, left: 3, bottom: 0, right: 3)
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    return 0
  }

  public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    return 7
  }
}
  // MARK: - EditableSongPresenting

extension EditableSongVc: EditableSongPresenting {
  public func renderRemoveItem(indexPath: IndexPath, song: SongResults) {
      self.collectionView.performBatchUpdates({
        self.collectionView.deleteItems(at: [indexPath])
      })
      self.sendUpdateOtherViews(with: song)
    }
}
