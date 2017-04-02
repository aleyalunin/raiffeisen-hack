//
//  SenderCell.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class SenderCell: MessageCell, MessageCellProtocol {

    //MARK: - MessageCellProtocol
    
    var message:String{
        get{
            return messageText
        }
        set{
            messageText = newValue
            textView.text = messageText
        }
    }

    var date:Date{
        get{
            return dateText
        }
        set{
            dateText = newValue
            dateLabel.text = getTime(date: dateText)
        }
    }
    
    @IBOutlet weak var cloudView: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var customView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cloudView.layer.cornerRadius = 17.5
        cloudView.layer.masksToBounds = true
        customView.layer.cornerRadius = 15.0
    }
    
}
