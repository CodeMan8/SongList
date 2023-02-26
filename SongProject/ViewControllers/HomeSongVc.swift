//
//  HomeSongVc.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit

class HomeSongVc: UIViewController, ButtonActionDelegate {

  @IBOutlet weak var tableView: UITableView!

  @IBOutlet weak var profileView: CustomProfileView!
  let viewModel = SongViewModel()

  override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareTableView()
    fetchSongPage()
    hideNavigationBar()
    NotificationCenter.default.addObserver(self, selector: #selector(self.removedItem), name: NSNotification.Name(rawValue: "removedItem"), object: nil)
  }

  func prepareTableView() {
    self.view.backgroundColor = .white
    self.tableView.separatorStyle   = .none
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: "SongTableViewCell", bundle: nil), forCellReuseIdentifier: "SongCell")

  }

  func fetchSongPage() {
    viewModel.fetchSongList()
    viewModel.fetchSongPage()
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
        songListResultVc.viewModel.songlistData(songs: self.viewModel.Allsongs, resultNumber: self.viewModel.resultNumber)
      }
    }

    if let thirdTAB = self.tabBarController?.viewControllers?[2] as? UINavigationController {
      if let songListCollectionVc = thirdTAB.viewControllers.first as? SongListCollectionVc {
        songListCollectionVc.viewModel.songlistData(songs: self.viewModel.Allsongs)
      }
    }

    if let lastTab = self.tabBarController?.viewControllers?[3] as? UINavigationController {
      if let editableListVc = lastTab.viewControllers.first as? EditableSongVc {
        editableListVc.viewModel.songs = self.viewModel.Allsongs
      }
    }
  }

  func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: "DetailPageVc") as? DetailPageVc else { return }
    detailVc.song = viewModel.firstPageSong[sender.tag]
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
    if let index = self.viewModel.firstPageSong.firstIndex(where: {$0.trackId == item.trackId}) {
      self.viewModel.firstPageSong.remove(at: index)

    }

    if let index = self.viewModel.Allsongs.firstIndex(where: {$0.trackId == item.trackId}) {
      self.viewModel.Allsongs.remove(at: index)
    }
  }
}


  // MARK: - UITableView Delegate And Datasource Methods
extension HomeSongVc: UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.firstPageSong.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    guard let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath as IndexPath) as? SongTableViewCell else {
      fatalError("SongCell cell is not found")
    }

    let song = viewModel.firstPageSong[indexPath.row]
    cell.primaryLabel.text = song.artistName
    cell.secondaryLabel.text = song.trackName
    cell.photoView?.image = try? UIImage(data: Data(contentsOf: URL(string: song.artworkUrl100)!))
    cell.configure(delegate: self, tag: indexPath.row)
    return cell
  }

  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if viewModel.isLastItem(row: indexPath.row) {
      if viewModel.offset < viewModel.resultCount {
        viewModel.increasePage()
      }
    }
  }

  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 160
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }

}
