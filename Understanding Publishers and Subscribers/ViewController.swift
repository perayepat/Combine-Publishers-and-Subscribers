//
//  ViewController.swift
//  Understanding Publishers and Subscribers
//
//  Created by Pat on 2023/03/17.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notification = Notification.Name("MyNotification")
        let center = NotificationCenter.default
        
        /// set up the observer
        let observer = center.addObserver(forName: notification, object: nil, queue: nil) { notification in
            print("Notification recieved")
        }
        
        center.post(name: notification, object: nil)
        /// The observer will be fired off because it's looking for a notification ("MyNotification")
        /// once you call a notificaiton you want to remove it once you're done
        
        center.removeObserver(observer)
        
    }


}

