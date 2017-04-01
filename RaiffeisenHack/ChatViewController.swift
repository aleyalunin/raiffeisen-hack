//
//  ChatViewController.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChatBotDelegate, UITextFieldDelegate {
    
    var messages:[Message]!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var stackView: UIStackView!
    
    var nibs = [ChatCell.receiver, ChatCell.sender]
    let bot = Acutus.instance
    let barHeight:CGFloat = 50.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.register(cellsFromNIB: nibs)
        
        messages = MessageLoader.instance.loadMessages()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        bot.delegate = self
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.contentInset.bottom = 50.0
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideKeyboardWhenTappedAround(view: tableView)
    }
    
    func register(cellsFromNIB:[ChatCell]){
        
        for cell in cellsFromNIB{
            let nib = UINib(nibName: cell.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cell.rawValue)
        }
        
    }
    
    //MARK: - Text Field
    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0{
                view.frame.origin.y -= keyboardSize.height - barHeight
            }
        }
        
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0{
                view.frame.origin.y += keyboardSize.height - barHeight
            }
        }
    }    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    //MARK: - Table Update
    
    func scrollToBottom(){
        let indexPath = IndexPath(row: messages.count-1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateTable(){
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: messages.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        scrollToBottom()
    }
    
    //MARK: - ChatBotDelegate
    
    func messageDidLoad(message: String) {
        let newMessage = SenderMessage(text: message, date: Date(), supporter: botSupporter)
        messages.append(newMessage)
        updateTable()
    }
    
    @IBAction func didTouchSendButton(_ sender: Any) {
        
        if textField.text != String(){
            let messageText = textField.text!
            let newMessage = ReceiverMessage(text: messageText, date: Date())
            messages.append(newMessage)
            updateTable()
            
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { (timer) in
                self.bot.getResponse(mes: messageText)
            })
            
            textField.text = String()
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
    
    //MARK: - Cells
    
    func drawReceiverCell(_ tableView: UITableView, _ indexPath: IndexPath, _ message: ReceiverMessage) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.receiver.rawValue, for: indexPath) as! ReceiverCell
        
        cell.message = message.text
        cell.date = message.date
        
        return cell
    }
    
    func drawSenderCell(_ tableView: UITableView, _ indexPath: IndexPath, _ message:SenderMessage) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ChatCell.sender.rawValue, for: indexPath) as! SenderCell
 
        cell.message = message.text
        cell.date = message.date
        
        var requireImageAndName = false
        
        if indexPath.row == messages.count-1{
            requireImageAndName = true
        }
        else if messages[indexPath.row+1] is ReceiverMessage
        {
            requireImageAndName = true
        }
 
        
        if requireImageAndName{
            cell.customView.image = message.supporter.image
            cell.nameLabel.text = message.supporter.name
        }
        else{
            cell.nameLabel.text = ""
        }
        
        return cell
    }
    
    
    

}
