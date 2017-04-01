//
//  GlobalCell.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

public enum BillingCell:String{
    case card = "Карты"
    case deposit = "Вклады и счета"
    case credit = "Кредиты"
}


class GlobalCell: UITableViewCell {
    
    @IBOutlet weak var topRightLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!
    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var bottomLeftLabel: UILabel!
    
    func setUpCellWith(operation: JSON) {
        let logo = operation["logo"].string
        imageViewOutlet?.image = UIImage(named: logo!)
        topLeftLabel?.text = operation["name"].string
        bottomLeftLabel?.text = operation["category"].string
        topRightLabel?.text = operation["amount"].intValue.stringFormat + " " + operation["currency"].string!
        if operation["amount"] > 0 {
            topRightLabel.textColor = greenColor
        }
        bottomRightLabel.text = nil
    }
    
    func setUpCellWith(_ billing: JSON, type: BillingCell) {
        
        topLeftLabel?.text = billing["name"].string
        let logo = billing["logo"].string!
        imageViewOutlet?.image = UIImage(named: logo)
        topRightLabel?.text = billing["balance"].intValue.stringNeutralFormat + " " + billing["currency"].string!
        
        switch type{
        case .card:
            
            bottomLeftLabel.text = billing["number"].string?.encodedNumber
            bottomRightLabel.text = nil
            
            break
        case .deposit:
            
            bottomLeftLabel.text = billing["info"].string
            
            bottomRightLabel.text = billing["rate"].intValue > 0 ? "Ставка: " + String(billing["rate"].doubleValue) + " %" : String()
            
            break
        case .credit:
 
            bottomLeftLabel.text = billing["info"].string
            
            bottomRightLabel.text = String(billing["toPay"].intValue) + " " + billing["currency"].string!
            
            break
        }
        
    }

}
