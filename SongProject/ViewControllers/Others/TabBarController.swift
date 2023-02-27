//
//  TabBarController.swift
//  SongProject
//
//  Created by Bartu on 24.02.2023.
//

import UIKit
public class TabBarController: UITabBarController {
  @IBInspectable var initialIndex: Int = 0

  public override func viewDidLoad() {
    super.viewDidLoad()
    selectedIndex = initialIndex
  }

}
