//
//  OperationTableViewCell.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class OperationTableViewCell: UITableViewCell {

    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    func setUpOperationCellWith(operation: JSON) {
        let logo = operation["logo"].string
        imageViewOutlet?.image = UIImage(named: logo!)
        nameLabel?.text = operation["name"].string
        categoryLabel?.text = operation["category"].string
        amountLabel?.text = operation["amount"].intValue.stringFormat + " " + operation["currency"].string!
        if operation["amount"] > 0 {
            amountLabel.textColor = greenColor
        }
    }
}
