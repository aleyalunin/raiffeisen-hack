//
//  ChatViewController.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var messages:[Message]!
    @IBOutlet weak var tableView: UITableView!
    var nibs = [ChatCell.receiver, ChatCell.sender]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register(cellsFromNIB: nibs)
    }
    
    func register(cellsFromNIB:[ChatCell]){
        
        for cell in cellsFromNIB{
            let nib = UINib(nibName: cell.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cell.rawValue)
        }
        
    }
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        if message is ReceiverMessage{
            return drawReceiverCell(tableView, indexPath, message as! ReceiverMessage)
        }
        else if message is SenderMessage{
            return drawSenderCell(tableView, indexPath, message as! SenderMessage)
        }

        return UITableViewCell()
        
    }
    
    func drawReceiverCell(_ tableView: UITableView, _ indexPath: IndexPath, _ message: ReceiverMessage) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.receiver.rawValue, for: indexPath) as! ReceiverCell
        
        return cell
    }
    
    func drawSenderCell(_ tableView: UITableView, _ indexPath: IndexPath, _ message:SenderMessage) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.sender.rawValue, for: indexPath) as! SenderCell
        
        return cell
    }
    
    
    //MARK: - UITableViewDelegate
    
    

}
