//
//  LineViewController.swift
//  iOS Swift App
//
//  Created by Arya Tschand on 9/14/19.
//  Copyright © 2019 PEC. All rights reserved.
//

import UIKit
import CoreBluetooth
import QuartzCore
import Firebase

enum MessageOption: Int {
    case noLineEnding,
    newline,
    carriageReturn,
    carriageReturnAndNewline
}

/// The option to add a \n to the end of the received message (to make it more readable)
enum ReceivedMessageOption: Int {
    case none,
    newline
}


class LineViewController: UIViewController, BluetoothSerialDelegate {
    
    @IBOutlet weak var Segmented: UISegmentedControl!
    
    @IBOutlet weak var Severity: UILabel!
    
    @IBOutlet weak var ConnectBtn: UIBarButtonItem!
    
    var ref: DatabaseReference!
    
    @IBAction func Connect(_ sender: Any) {
        if serial.connectedPeripheral == nil {
            performSegue(withIdentifier: "ShowScanner", sender: self)
        } else {
            serial.disconnect()
            reloadView()
        }
    }
    
    @IBAction func SeverityChanged(_ sender: Any) {
        if Segmented.selectedSegmentIndex == 0 {
            //printMessagesForUser(parameters: "Temperature")
            getImageDB(value2: "temperatureGraph")
        } else if Segmented.selectedSegmentIndex == 1 {
            //printMessagesForUser(parameters: "Humidity")
            getImageDB(value2: "humidityGraph")
            
        } else if Segmented.selectedSegmentIndex == 2 {
            //printMessagesForUser(parameters: "Air")
            getImageDB(value2: "airGraph")
            
        } else if Segmented.selectedSegmentIndex == 3 {
            //printMessagesForUser(parameters: "Severity")
            getImageDB(value2: "severityGraph")
        }
    }
    
    
    @IBOutlet weak var imageview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        serial = BluetoothSerial(delegate: self)
        
        // UI
        //mainTextView.text = ""
        reloadView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LineViewController.reloadView), name: NSNotification.Name(rawValue: "reloadStartViewController"), object: nil)
    }
    
    func getImageDB(value2: String) {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var temp: String = value?[value2] as! String
            var strBase64 = temp
            let dataDecoded:NSData = NSData(base64Encoded: strBase64, options: NSData.Base64DecodingOptions(rawValue: 0))!
            let decodedimage:UIImage = UIImage(data: dataDecoded as Data)!
            self.imageview.image = decodedimage// Do any additional setup after loading the view.
        })
    }
    
    func updateTitle() {
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            var temp: String = value?["severityScore"] as! String
            self.Severity.text = "Severity Score = \(temp)"
            if Int(temp)! < 20 {
                self.Severity.textColor = UIColor.green
            } else if Int(temp)! < 40 {
                self.Severity.textColor = UIColor.orange
            } else {
                self.Severity.textColor = UIColor.red
            }
        })
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        // bring the text field back down..
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
        }, completion: nil)
        
    }
    
    func textViewScrollToBottom() {
        //let range = NSMakeRange(NSString(string: mainTextView.text).length - 1, 1)
        //mainTextView.scrollRangeToVisible(range)
    }
    
    func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
        reloadView()
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.mode = MBProgressHUDMode.text
        hud?.labelText = "Disconnected"
        hud?.hide(true, afterDelay: 1.0)
    }
    
    func serialDidChangeState() {
        reloadView()
        if serial.centralManager.state != .poweredOn {
            let hud = MBProgressHUD.showAdded(to: view, animated: true)
            hud?.mode = MBProgressHUDMode.text
            hud?.labelText = "Bluetooth turned off"
            hud?.hide(true, afterDelay: 1.0)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadView()
        getImageDB(value2: "temperatureGraph")
        updateTitle()
    }

    func printMessagesForUser(parameters: String) {
        let json = [parameters]
        print(json)
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
    
    func serialDidReceiveString(_ message: String) {
        printMessagesForUser(parameters: message)
        if Segmented.selectedSegmentIndex == 0 {
            //printMessagesForUser(parameters: "Temperature")
            getImageDB(value2: "temperatureGraph")
        } else if Segmented.selectedSegmentIndex == 1 {
            //printMessagesForUser(parameters: "Humidity")
            getImageDB(value2: "humidityGraph")
            
        } else if Segmented.selectedSegmentIndex == 2 {
            //printMessagesForUser(parameters: "Air")
            getImageDB(value2: "airGraph")
            
        } else if Segmented.selectedSegmentIndex == 3 {
            //printMessagesForUser(parameters: "Severity")
            getImageDB(value2: "severityGraph")
        }
        updateTitle()
        /*
        
        let doc = try SwiftSoup.parse(htmlcontents)
        do{
            let element = try doc.select("head").array()
            print(element)
        } catch {
            
        }
 */
        /*
        if !temprfid.contains(message) {
            temprfid.append(message)
            sendName(inputtemp2: message)
        } else {
            sendName(inputtemp2: "double")
        }*/
        
        //let pref = UserDefaults.standard.integer(forKey: ReceivedMessageOption)
        //if pref == ReceivedMessageOption.newline.rawValue { mainTextView.text! += "\n" }
    }
    
    @objc func reloadView() {
        // in case we're the visible view again
        serial.delegate = self
        
        if serial.isReady {
            ConnectBtn.title = "Disconnect"
            ConnectBtn.tintColor = UIColor.red
            ConnectBtn.isEnabled = true
            serial.sendMessageToDevice("initialize")
        } else if serial.centralManager.state == .poweredOn {
            ConnectBtn.title = "Connect"
            ConnectBtn.tintColor = view.tintColor
            ConnectBtn.isEnabled = true
            serial.sendMessageToDevice("DISCONNECT")
        } else {
            ConnectBtn.title = "Connect"
            ConnectBtn.tintColor = view.tintColor
            ConnectBtn.isEnabled = false
            serial.sendMessageToDevice("DISCONNECT")
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        // animate the text field to stay above the keyboard
        var info = (notification as NSNotification).userInfo!
        let value = info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyboardFrame = value.cgRectValue
        
        //TODO: Not animating properly
        UIView.animate(withDuration: 1, delay: 0, options: UIView.AnimationOptions(), animations: { () -> Void in
        }, completion: { Bool -> Void in
            self.textViewScrollToBottom()
        })
    }

}
