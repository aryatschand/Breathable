//
//  HelpTableViewController.swift
//  
//
//  Created by Arya Tschand on 9/14/19.
//

import UIKit
import Foundation
import MessageUI

class HelpTableViewController: UITableViewController, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {

    var names: [String] = ["WildLife", "Ocean"]
    var numbers: [String] = ["7325356202", "7324465525"]
    var emails: [String] = ["arya@voicesaver.com", "arya@gmail.com"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result.rawValue {
        default:
            break
        }
        controller.dismiss(animated: true, completion: nil)
    }
    
    // Set up emailing feature
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "row", for: indexPath)
        cell.textLabel?.text = names[indexPath.row] + " - " + numbers[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        composeVC.setToRecipients([emails[indexPath.row]])
        composeVC.setSubject("Environmental Volunteer")
        self.present(composeVC, animated: true, completion: nil)
    }

}
