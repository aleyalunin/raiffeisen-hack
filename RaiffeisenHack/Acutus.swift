//
//  Acutus.swift
//  RaiffeisenHack
//
//  Created by Kirill Korolev on 01/04/17.
//  Copyright © 2017 Kirill Korolev. All rights reserved.
//

import Foundation

public protocol ChatBotDelegate:class{
    func messageDidLoad(message:String)
}

class Acutus:NSObject, URLSessionDataDelegate{
    
    static let instance = Acutus()
    weak var delegate:ChatBotDelegate!
    var data: NSMutableData!
    var urlPath: String!
    
    func getResponse(mes: String){
        
        let test = mes.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        urlPath = "http://kafafyf-001-site1.itempurl.com/Default.aspx?msg=" + test
        data = NSMutableData()
        
        let url = URL(string: urlPath)!
        var session: URLSession!
        let configuration = URLSessionConfiguration.default
        
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: url)
        task.resume()
        
    }
    
    //MARK: URLSessionDataDelegate
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.data.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?){
        if error != nil{
            print("Failed to download data")
            return
        }
        else{
            print("Data has been downloaded")
            
            let htmlResponse = String(data: data as Data, encoding: String.Encoding.utf8)!
            
            DispatchQueue.main.async{
                self.delegate.messageDidLoad(message: htmlResponse)
            }
            
        }
    }
    
    func parseString(_ string:String){
        let pattern = "<break>([\\s\\S]*)"
        let matched = matches(for: pattern, in: string)
        print(matched)
    }
    
    
    
}
