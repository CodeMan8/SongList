//
//  SongListResultVc.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

class SongListResultVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var resultLabel: UILabel!

  @IBOutlet weak var profileView: CustomProfileView!
  var viewModel = SongViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareTableView()
    hideNavigationBar()
  }

  override func viewWillAppear(_ animated: Bool) {
    self.resultLabel.text = self.viewModel.resultNumber
    super.viewWillAppear(animated)
  }

  func prepareTableView() {
    self.view.backgroundColor = .white
    self.tableView.separatorStyle   = .none
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongCell")
  }

  func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.tableView.reloadData()
      }
    }
  }

  func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.songs[sender.tag]
    self.navigationController?.pushViewController(detailVc, animated: true)
  }

  private func  hideNavigationBar() {
    self.navigationController?.navigationBar.isHidden = true
  }

}

  // MARK: - UITableView Delegate And Datasource Methods
extension SongListResultVc: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.songs.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath as IndexPath) as? SongTableViewCell else {
      fatalError("SongCell cell is not found")
    }

    let song = viewModel.songs[indexPath.row]
    cell.primaryLabel.text = song.artistName
    cell.secondaryLabel.text = song.trackName
    cell.photoView?.isHidden = true
    cell.configure(delegate: self, tag: indexPath.row)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 160
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }
}
