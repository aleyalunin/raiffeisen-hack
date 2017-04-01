//
//  PaymentsController.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class PaymentsController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sections = DataLoader.getSections()
    
    @IBOutlet weak var tableView:UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        addDataToSections()
        
    }
    
    func addDataToSections(){
        
        let favorites = DataLoader.getFavorites()
        let contacts = DataLoader.getContacts()
        
        for favorite in favorites{
            sections[0].cells.append(favorite.name)
        }
 
        for contact in contacts{
            sections[3].cells.append(contact.fullname)
        }
        
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].section
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].cells.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell")!
        cell.textLabel?.text = sections[indexPath.section].cells[indexPath.row]
        return cell
    }
    

}
