//
//  HomeSongVc.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

class HomeSongVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var tableView: UITableView!

  let viewModel = SongViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareTableView()
    fetchSongList()
    hideNavigationBar()
  }

  func prepareTableView() {
    self.view.backgroundColor = .white
    self.tableView.separatorStyle   = .none
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongCell")

  }

  func fetchSongList() {
    viewModel.fetchSongList()
  }

  func prepareViewModelObserver() {
    self.viewModel.dataChanges = { (finished, error) in
      if !error {
        self.tableView.reloadData()
        self.passData()

      }
    }
  }
  private func passData() {
    if let secondTab = self.tabBarController?.viewControllers?[1] as? UINavigationController {
      if let songListResultVc = secondTab.viewControllers.first as? SongListResultVc {
        songListResultVc.viewModel = self.viewModel
      }
    }

    if let thirdTAB = self.tabBarController?.viewControllers?[2] as? UINavigationController {
      if let songListCollectionVc = thirdTAB.viewControllers.first as? SongListCollectionVc {
        songListCollectionVc.viewModel = self.viewModel
      }
    }

    if let lastTab = self.tabBarController?.viewControllers?[3] as? UINavigationController {
      if let editableListVc = lastTab.viewControllers.first as? EditableSongVc {
        editableListVc.viewModel = self.viewModel
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
extension HomeSongVc: UITableViewDelegate, UITableViewDataSource {

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
    cell.photoView?.image = try? UIImage(data: Data(contentsOf: URL(string: song.artworkUrl100)!))
    cell.configure(delegate: self, tag: indexPath.row)
    return cell
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 160
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }

}
