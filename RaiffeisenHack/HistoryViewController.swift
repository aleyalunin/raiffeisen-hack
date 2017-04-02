//
//  HistoryViewController.swift
//  RaiffeisenHack
//
//  Created by Alexander on 01/04/2017.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var historyTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        historyTableView.delegate = self
        historyTableView.dataSource = self
        
        let nib = UINib(nibName: "GlobalCell", bundle: nil)
        historyTableView.register(nib, forCellReuseIdentifier: "GlobalCell")
        
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return historyDataJson.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return historyDataJson[section]["operations"].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = historyTableView.dequeueReusableCell(withIdentifier: "GlobalCell", for: indexPath)
        
        
        if let operationCell = cell as? GlobalCell{
            let operation = historyDataJson[indexPath.section]["operations"][indexPath.row]
            operationCell.setUpCellWith(operation: operation)
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = .white
        
        let label = UILabel(frame: CGRect(x: 15,y: 0, width: tableView.bounds.size.width, height: 30))
        label.text = historyDataJson[section]["date"].string
        label.font = UIFont.systemFont(ofSize: 14, weight: UIFontWeightSemibold)
        
        headerView.addSubview(label)
        
        return headerView
    }
    
    // Design stuff
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 30))
        footerView.backgroundColor = UIColor.clear
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.performSegue(withIdentifier: Global.Segues.historySegue, sender: self)
    }
    
    




}
