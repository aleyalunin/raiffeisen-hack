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
        messages.append(SenderMessage(text: "Здравствуйте, я бот, чем я могу вам помочь? Для связи со специалистом наберите /direct", date: Date(), supporter: Global.botSupporter))
        
        return messages
    }
    
}
