//
//  Utils.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation

public enum ChatCell:String{
    case receiver = "ReceiverCell"
    case sender = "SenderCell"
}

protocol MessageCellProtocol{
    var message:String { get set }
    var date:Date { get set }
}

struct Payment{
    var section:String
    var cells:[String]
}

struct Transaction{
    var name:String
}

struct Contact{
    var fullname:String
}

class DataLoader{
    
    static func getSections() -> [Payment]{
        return [Payment(section: "Избранное", cells: []),
        Payment(section: "Переводы", cells: ["Между своими банками","Клиенту Райффайзена","На карту в другой банк","На счет в другой банк","Запросы денег"]),
        Payment(section: "Платежи", cells: ["Мобильная связь","Коммунальные платежи","Интернет и ТВ","Налоги, штрафы, ГИБДД","Остальное"]),
        Payment(section: "Контакты", cells: [])]
    }

    static func getFavorites() -> [Transaction]{
        return [Transaction(name: "TELE2"), Transaction(name:"Ростелеком")]
    }

    static func getContacts() -> [Contact]{
        return [Contact(fullname: "Александр Широков"), Contact(fullname:"Дмитрий Шварц")]
    }
    
}

