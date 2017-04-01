//
//  GlobalTabBarController.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class GlobalTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UITabBar.appearance().tintColor = .black
        self.tabBar.unselectedItemTintColor = .gray
    }

}
