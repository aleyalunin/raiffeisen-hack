//
//  SenderCell.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class SenderCell: MessageCell, MessageCellProtocol {

    var message:String{
        get{
            return messageText
        }
        set{
            messageText = newValue
            textView.text = messageText
        }
    }
    
    
    @IBOutlet weak var cloudView: UIView!
    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cloudView.layer.cornerRadius = 15.0
        cloudView.layer.masksToBounds = true
    }
    
}
