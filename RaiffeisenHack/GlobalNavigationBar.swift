//
//  GlobalNavigationBar.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

@IBDesignable
class GlobalNavigationBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        UINavigationBar.appearance().barTintColor = orangeColor
    }

}
