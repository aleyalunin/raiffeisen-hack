//
//  MoreViewController.swift
//  RaiffeisenHack
//
//  Created by Alexander on 02/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class MoreViewController: UITableViewController {

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: Global.Segues.moreSegue, sender: self)
    }
}
