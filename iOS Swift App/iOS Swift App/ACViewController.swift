//
//  ACViewController.swift
//  iOS Swift App
//
//  Created by Arya Tschand on 9/14/19.
//  Copyright © 2019 PEC. All rights reserved.
//

import UIKit
import Firebase

class ACViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        printMessagesForUser(parameters: "Air")
    }
    
    func printMessagesForUser(parameters: String) {
        let json = [parameters]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
            
            let url = NSURL(string: "https://h2hacks1.herokuapp.com/api")!
            let request = NSMutableURLRequest(url: url as URL)
            request.httpMethod = "POST"
            
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request as URLRequest){ data, response, error in
                if let string = String(data: data!, encoding: .utf8) {
                    print(string)
                    //self.Severity.text = "hello"
                } else {
                    print("not a valid UTF-8 sequence")
                }
                
            }
            task.resume()
        } catch {
            print(error)
        }
    }

}
