
import UIKit
import Combine

class StringSubscriber: Subscriber{
    
    //Gets the sub
    func receive(subscription: Subscription) {
        /// Sub recieves the subscription
        print("Recieved Subscription")
        subscription.request(.max(3)) // backpressure - when the publisher sends you a lot of values and you only need a selected amount
    }
    
    //Gets the value
    func receive(_ input: String) -> Subscribers.Demand {
        print("Recieved Value", input)
        // when can change the backpressure here
//        return .none
        return .unlimited
    }
    
    //recieves the completion
    func receive(completion: Subscribers.Completion<Never>) {
        print("completed")
    }
    
    typealias Input = String
    typealias Failure = Never
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
            
        let publisher = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"].publisher
        
        let subscriber = StringSubscriber()
        publisher.subscribe(subscriber)
        

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

