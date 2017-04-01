//
//  Utils.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation

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
        return format()
    }
    
    func format() -> String{
        var array = [String]()
        var string = ""
        let pred = self < 0 ? "-":"+"
        
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

public enum ChatCell:String{
    case receiver = "ReceiverCell"
    case sender = "SenderCell"
}

protocol MessageCellProtocol{
    var message:String { get set }
    var date:Date { get set }
}

extension Acutus{
    
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
    
}
