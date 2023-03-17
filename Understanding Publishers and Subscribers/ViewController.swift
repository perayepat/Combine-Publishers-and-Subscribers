
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let notification = Notification.Name("MyPublisherNotification")
        
        let publisher = NotificationCenter.default.publisher(for: notification,object: nil)
        
        ///The `sink` function means that you want to subscribe to that specific publisher
        ///this does return a sub
        ///Needs to be before the post other wise nothing gets fired off
        let subscription = publisher.sink { _ in
            print("Notification recieved from sink")
        }
        
        NotificationCenter.default.post(name: notification, object: nil)
        
     
    }
}

extension ViewController{
    func usingImperativeProgramming(){
        //MARK: - Imperative programming
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

