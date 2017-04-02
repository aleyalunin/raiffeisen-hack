//
//  Utils.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation
import UIKit

extension String{
var length: Int{
    return self.characters.count
}

subscript(i: Int) -> String{
    return self[Range(i..<i+1)]
}

subscript(r: Range<Int>) -> String{
    let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)), upper: min(length, max(0, r.upperBound))))
    let start = index(startIndex, offsetBy: range.lowerBound)
    let end = index(start, offsetBy: range.upperBound - range.lowerBound)
    return self[start..<end]
}
}

public extension Int{
    var stringFormat: String{
        return format(isNeutral: false)
    }
    
    var stringNeutralFormat:String{
        return format(isNeutral: true)
    }
    
    
    func format(isNeutral: Bool) -> String{
        var array = [String]()
        var string = ""
        var pred = String()
        
        if !isNeutral{
            pred = self < 0 ? "-":"+"
        }

        
        splitNumber(&array)
        reverseFill(string: &string, array: array)
        
        return pred + string
    }
    
    func splitNumber(_ array: inout [String]){
        
        var number = abs(self)
        
        while number > 0 {
            let mod = number % 1000
            var modString = ""
            
            if mod == 0{
                modString = "000"
            }
            else{
                modString = "\(mod)"
            }
            
            array.append(modString)
            number = number / 1000
        }
    }
    
    func reverseFill(string: inout String, array:[String]){
        
        for i in 0..<array.count{
            var predicate = ""
            let j = array.count-i-1
            
            if j != array.count-1{
                predicate = " "
            }
            string += predicate+array[j]
        }
        
    }
    
}


extension String{
    var encodedNumber:String{
        return encode()
    }
    
    func encode() -> String{
        return "**** " + self[self.length-5..<self.length-1]
    }
    
}

func matches(for regex: String, in text: String) -> [String] {
    
    do {
        let regex = try NSRegularExpression(pattern: regex)
        let nsString = text as NSString
        let results = regex.matches(in: text, range: NSRange(location: 0, length: nsString.length))
        return results.map { nsString.substring(with: $0.range)}
    } catch let error {
        print("invalid regex: \(error.localizedDescription)")
        return []
    }
}

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


