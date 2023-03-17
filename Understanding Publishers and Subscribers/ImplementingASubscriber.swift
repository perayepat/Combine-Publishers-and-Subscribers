import UIKit
import Combine
//MARK: - Implementing a subscriber

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

extension ViewController{
    func subscriberClass(){
        let publisher = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K"].publisher
        
        let subscriber = StringSubscriber()
        publisher.subscribe(subscriber)
        
    }
}
