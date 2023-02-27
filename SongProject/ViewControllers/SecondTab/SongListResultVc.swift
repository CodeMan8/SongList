  //
  //  SongListResultVc.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit

public class SongListResultVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var resultLabel: UILabel!

  @IBOutlet weak var profileView: CustomProfileView!
  var viewModel = SecondViewModel()

  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareTableView()
    NotificationCenter.default.addObserver(self, selector: #selector(self.removedItem), name: NSNotification.Name(rawValue: "removedItem"), object: nil)
    viewModel.songs = viewModel.results
  }

  public override func viewWillAppear(_ animated: Bool) {
    self.resultLabel.text = viewModel.resultNumberText
    hideNavigationBar()
    super.viewWillAppear(animated)
  }

  private func prepareTableView() {
    self.tableView.separatorStyle   = .none
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: Constants.Cell.tableCellNib, bundle: nil), forCellReuseIdentifier: Constants.Cell.cellReuse)
  }

  private func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.tableView.reloadData()
      }
    }
  }

  public func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.songs[sender.tag]
    self.navigationController?.pushViewController(detailVc, animated: true)
  }

  private func  hideNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }

  @objc public  func removedItem(notification: NSNotification) {
    if let song = notification.object as? SongResults {
      remove(with: song)
    }
  }

  private func remove(with item: SongResults) {
    if let index = self.viewModel.songs.firstIndex(where: {$0.trackId == item.trackId}) {
      self.viewModel.songs.remove(at: index)
    }
  }

}

  // MARK: - UITableView Delegate And Datasource Methods
extension SongListResultVc: UITableViewDelegate, UITableViewDataSource {

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getNumberOfRows()
  }

  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.cellReuse, for: indexPath as IndexPath) as? SongTableViewCell else {
      fatalError("SongCell cell is not found")
    }

    let song = viewModel.getCellViewModel(at: indexPath)
    cell.hidePhotoView()
    cell.configure(delegate: self, tag: indexPath.row, result: song)
    return cell
  }

  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 160
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }
}
