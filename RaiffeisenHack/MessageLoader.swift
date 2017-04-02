//
//  MessageLoader.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation

class MessageLoader:NSObject{
    
    static let instance = MessageLoader()
    
    func loadMessages() -> [Message]{
        
        var messages = [Message]()
        messages.append(ReceiverMessage(text: "1238273487238478", date: Date()))
        messages.append(SenderMessage(text: "Чем я могу вам помочь?", date: Date(), supporter: supporter))
        messages.append(SenderMessage(text: "Чем я могу вам помочь?", date: Date(), supporter: supporter))
        
        return messages
    }
    
}
