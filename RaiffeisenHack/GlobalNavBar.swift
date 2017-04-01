//
//  GlobalNavBar.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

@IBDesignable
class GlobalNavBar: UINavigationBar {

    override func layoutSubviews() {
        super.layoutSubviews()
        self.barTintColor = orangeColor
    }

    
}
