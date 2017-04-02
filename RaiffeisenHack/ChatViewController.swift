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
        
        tableView.estimatedRowHeight = 36.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        textField.delegate = self
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        self.hideKeyboardWhenTappedAround(tblView: tableView)
    }
    
    func register(cellsFromNIB:[ChatCell]){
        
        for cell in cellsFromNIB{
            let nib = UINib(nibName: cell.rawValue, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cell.rawValue)
        }
        
    }

    //MARK: - Text Field
    
    func hideKeyboardWhenTappedAround(tblView: UITableView) {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tblView.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        self.textField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.textField.resignFirstResponder()
        return true
    }

    
    func keyboardWillShow(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y != 0{
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
    
    //MARK: - Table Update
    
    func scrollToBottom(){
        let indexPath = IndexPath(row: messages.count-1, section: 0)
        tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }
    
    func updateTable(){
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: messages.count-1, section: 0)], with: .automatic)
        tableView.endUpdates()
        
        if messages[messages.count-1] is SenderMessage{
            
            var i = messages.count-2
            var paths = [IndexPath]()
            
            while i > 0{
                
                if messages[i] is SenderMessage{
                    let indexPath = IndexPath(row: i, section: 0)
                    paths.append(indexPath)
                }
                
                i -= 1
            }
            
            tableView.reloadRows(at: paths, with: .none)
        }
        
        
        updateContentInsetForTableView(tableView: self.tableView, animated: true)
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
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
        
        var isLast = false
        
        if indexPath.row == messages.count-1{
            isLast = true
        }
        else if messages[indexPath.row+1] is ReceiverMessage
        {
            isLast = true
        }
        
 
        
        if isLast{
            cell.customView.image = message.supporter.image
            cell.nameLabel.text = message.supporter.name
        }
        else{
            cell.customView.image = nil
            cell.nameLabel.text = String()
        }
        
        return cell
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateContentInsetForTableView(tableView: self.tableView, animated:false)
    }
    
    
    func updateContentInsetForTableView(tableView: UITableView, animated:Bool){
        let lastRow = tableView.numberOfRows(inSection: 0)
        let lastIndex = lastRow > 0 ? lastRow - 1 : 0
        let lastIndexPath = IndexPath(row: lastIndex, section: 0)
        let lastCellFrame = tableView.rectForRow(at: lastIndexPath)
        let topInset = max(tableView.frame.height - lastCellFrame.origin.y - lastCellFrame.height, 0) - 25.0
        var contentInset = tableView.contentInset
        contentInset.top = topInset
        
        let options = UIViewAnimationOptions.beginFromCurrentState
        
        UIView.animate(withDuration: animated ? 0.25 : 0.0, delay: 0.0, options: options, animations: {
            
            tableView.contentInset = contentInset
            
        }, completion: nil)
        
    }
    
    //MARK: - URL
    
    func openURL(url:String!){
        
        if let targetURL = URL(string: url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(targetURL, options: [:],
                                          completionHandler: nil)
            } else {
                _ = UIApplication.shared.openURL(targetURL)
            }
        }
    }

    
}
