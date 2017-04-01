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
    var message:String!
    weak var delegate:ChatBotDelegate!
    var data: NSMutableData!
    var urlPath: String!
    
    func getResponse(message: String){
        
        urlPath = "http://kafafyf-001-site1.itempurl.com/Default.aspx?msg=" + message
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
            self.parseJSON()
        }
    }
    
    func parseJSON(){
     
        var jsonResult = NSArray()
        
        do {
            try jsonResult = JSONSerialization.jsonObject(with: self.data as Data, options: .allowFragments) as! NSArray
        } catch let error {
            print(error)
        }
        
        var jsonDictionary = NSDictionary()
        
        
        for i in 0..<jsonResult.count{
            jsonDictionary = jsonResult[i] as! NSDictionary
            
            message = jsonDictionary["message"] as! String
        }
        
        DispatchQueue.main.async{
            self.delegate.messageDidLoad(message: self.message)
        }
        
        
    }
    
    
    
}
