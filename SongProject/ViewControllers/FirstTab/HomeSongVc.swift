  //
  //  HomeSongVc.swift
  //  SongProject
  //
  //  Created by Bartu on 24.02.2023.
  //

import UIKit

public class HomeSongVc: UIViewController, ButtonActionDelegate {
  
  @IBOutlet weak var tableView: UITableView!
  @IBOutlet weak var profileView: CustomProfileView!

  let viewModel = SongViewModel()
  
  public override func viewDidLoad() {
    super.viewDidLoad()
    prepareViewModelObserver()
    prepareTableView()
    fetchSongPage()
    NotificationCenter.default.addObserver(self, selector: #selector(self.removedItem), name: NSNotification.Name(rawValue: "removedItem"), object: nil)
  }
  
  public override func viewWillAppear(_ animated: Bool) {
    hideNavigationBar()
    super.viewWillAppear(animated)
  }
  
  private func prepareTableView() {
    self.tableView.separatorStyle   = .none
    self.tableView.delegate = self
    self.tableView.dataSource = self
    self.tableView.register(UINib(nibName: Constants.Cell.tableCellNib, bundle: nil), forCellReuseIdentifier: Constants.Cell.cellReuse)
    
  }
  
  private func fetchSongPage() {
    viewModel.fetchSongList()
    viewModel.fetchSongPage()
  }
  
  private func prepareViewModelObserver() {
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
        songListResultVc.viewModel.songlistData(songs: self.viewModel.otherResults)
      }
    }
    
    if let thirdTAB = self.tabBarController?.viewControllers?[2] as? UINavigationController {
      if let songListCollectionVc = thirdTAB.viewControllers.first as? SongListCollectionVc {
        songListCollectionVc.viewModel.songlistData(songs: self.viewModel.otherResults)
      }
    }
    
    if let lastTab = self.tabBarController?.viewControllers?[3] as? UINavigationController {
      if let editableListVc = lastTab.viewControllers.first as? EditableSongVc {
        editableListVc.viewModel.songs = self.viewModel.otherResults
      }
    }
  }
  
  public func applyButtonPressed(_ sender: UIButton) {
    guard let detailVc = self.storyboard?.instantiateViewController(withIdentifier: Constants.detailPage) as? DetailPageVc else { return }
    detailVc.song = viewModel.firstPageResults[sender.tag]
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
    if let index = self.viewModel.firstPageResults.firstIndex(where: {$0.trackId == item.trackId}) {
      self.viewModel.firstPageResults.remove(at: index)
    }
    
    if let index = self.viewModel.otherResults.firstIndex(where: {$0.trackId == item.trackId}) {
      self.viewModel.otherResults.remove(at: index)
    }
  }
}


  // MARK: - UITableView Delegate And Datasource Methods
extension HomeSongVc: UITableViewDelegate, UITableViewDataSource {
  
  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getNumberOfRows()
  }
  
  public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell: SongTableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.Cell.cellReuse, for: indexPath as IndexPath) as? SongTableViewCell else {
      fatalError("SongCell cell is not found")
    }
    
    let song = viewModel.getCellViewModel(at: indexPath)
    cell.configure(delegate: self, tag: indexPath.row, result: song)
    return cell
  }
  
  public func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if viewModel.isLastItem(row: indexPath.row) {
      if viewModel.offset < viewModel.resultCount {
        viewModel.increasePage()
      }
    }
  }
  
  public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    tableView.estimatedRowHeight = 160
    tableView.rowHeight = UITableView.automaticDimension
    return UITableView.automaticDimension
  }
  
}
