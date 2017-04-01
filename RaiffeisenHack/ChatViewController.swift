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
    
    
    var nibs = [ChatCell.receiver, ChatCell.sender]
    let bot = Acutus.instance
    
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
        
        textField.becomeFirstResponder()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.showKeyboard(notification:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func register(cellsFromNIB:[ChatCell]){
        
        for cell in cellsFromNIB{
            let nib = UINib(nibName: cell.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cell.rawValue)
        }
        
    }
    
    //MARK: - Text Field
    
    func showKeyboard(notification: Notification) {
        if let frame = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let height = frame.cgRectValue.height
            self.tableView.contentInset.bottom = height
            self.tableView.scrollIndicatorInsets.bottom = height
            if messages.count > 0 {
                self.tableView.scrollToRow(at: IndexPath.init(row: messages.count - 1, section: 0), at: .bottom, animated: true)
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - ChatBotDelegate
    
    func messageDidLoad(message: String) {
        let newMessage = SenderMessage(text: message, date: Date(), supporter: botSupporter)
        messages.append(newMessage)
        tableView.reloadData()
    }
    
    @IBAction func didTouchSendButton(_ sender: Any) {
        
        if textField.text != String(){
            let messageText = textField.text!
            let newMessage = ReceiverMessage(text: messageText, date: Date())
            messages.append(newMessage)
            tableView.reloadData()
            
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
        
        var requireImage = false
        
        if indexPath.row == messages.count-1{
            requireImage = true
        }
        else if messages[indexPath.row+1] is ReceiverMessage
        {
            requireImage = true
        }
        
        
        if requireImage{
            cell.customView.image = message.supporter.image
        }
        
        return cell
    }
    
    
    

}
