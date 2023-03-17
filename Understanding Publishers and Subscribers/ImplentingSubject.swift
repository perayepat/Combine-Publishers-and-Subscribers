import UIKit
import Combine

enum MyError: Error{
    case subscriberError
}

class StringSubjectSubscriber: Subscriber{
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
//        return .none // How do you want to increase the demand
        return.max(1) // This will increase the demand by one
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("completion")
    }
    
    typealias Input = String
    typealias Failure = MyError
  
}

