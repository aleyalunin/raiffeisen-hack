//
//  SenderMessage.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation

class SenderMessage:Message{
    
    var supporter: Supporter
    
    init(text: String, date:Date, supporter: Supporter) {
        self.supporter = supporter
        super.init(text: text, date: date)
    }
    
}
