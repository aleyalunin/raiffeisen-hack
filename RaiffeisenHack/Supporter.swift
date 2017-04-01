//
//  Supporter.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation
import UIKit

class Supporter{
    
    var isBot: Bool
    var name:String?
    var image:UIImage
    
    init(image:UIImage) {
        self.isBot = true
        self.image = image
    }
    
    init(name:String, image:UIImage) {
        self.isBot = false
        self.name = name
        self.image = image
    }

    
}
