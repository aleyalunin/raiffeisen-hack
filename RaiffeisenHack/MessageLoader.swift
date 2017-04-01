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
        
        messages.append(ReceiverMessage(text: "Добрый день, будьте добры, расскажите о комиссии при переводе на карту Райффайзена?", date: Date()))
        messages.append(SenderMessage(text: "хз", date: Date(), supporter: supporter))
        messages.append(SenderMessage(text: "попробуйте перевести", date: Date(), supporter: supporter))
        
        return messages
    }
    
}
