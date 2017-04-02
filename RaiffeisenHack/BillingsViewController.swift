//
//  BillingsViewController.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class BillingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var billingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billingsTableView.delegate = self
        billingsTableView.dataSource = self
        
        let nib = UINib(nibName: "GlobalCell", bundle: nil)
        billingsTableView.register(nib, forCellReuseIdentifier: "GlobalCell")
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return billingsDataJSON.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return billingsDataJSON[section]["entities"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = billingsTableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath)
        
        
        if let billingCell = cell as? GlobalCell{
            let billing = billingsDataJSON[indexPath.section]["entities"][indexPath.row]
            billingCell.setUpCellWith(billing, type: BillingCell(rawValue: billingsDataJSON[indexPath.section]["type"].string!)!)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return billingsDataJSON[section]["type"].string
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85.0
    }

    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: Global.Segues.billingsSegue, sender: self)
    }
    
}
