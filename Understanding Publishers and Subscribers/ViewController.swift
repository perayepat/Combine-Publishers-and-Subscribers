
import UIKit
import Combine


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        // Subjects
        // - Publisher
        // - Subscribers
        
        let subscriber = StringSubjectSubscriber()
        
        let subject = PassthroughSubject<String, MyError>()
        
        subject.subscribe(subscriber) // Creating a subscription
        
    
        let subscriptionUsingSink = subject.sink { (completion) in
            print("Received completino from sink")
        } receiveValue: { value in
            print("receieved value from sink")
        }
    ///At this point we will recieve values from the first subscriber and the sink
        
        //now the subject can send a value to the subscriber
        subject.send("A")
        subject.send("B")
        
        subscriptionUsingSink.cancel()
        
        subject.send("C")
        subject.send("D")
        
        /*
         Subjects allow us to send data on demand and allow us to use subscribers 
         */
        

        

    }
}

//MARK: -  Using the notificaiton center
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


//MARK: - Sending notificaitons using publisher and subscriber
extension ViewController{
    func usingTheObserverPublihserPattern(){
        let notification = Notification.Name("MyPublisherNotification")
        
        let publisher = NotificationCenter.default.publisher(for: notification,object: nil)
        
        ///The `sink` function means that you want to subscribe to that specific publisher
        ///this does return a sub
        ///Needs to be before the post other wise nothing gets fired off
        let subscription = publisher.sink { _ in
            print("Notification recieved from sink")
        }
        
        NotificationCenter.default.post(name: notification, object: nil)
        
        ///This is how we cancel a subscription so that we won't get any updates
        subscription.cancel()
    
    }
}

