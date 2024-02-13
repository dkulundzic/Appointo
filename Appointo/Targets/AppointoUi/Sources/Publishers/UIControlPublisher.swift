// Credit to https://www.avanderlee.com/swift/custom-combine-publisher/

import UIKit
import Combine

public struct UIControlPublisher<Control: UIControl>: Publisher {
    public typealias Output = Control
    public typealias Failure = Never

    private let control: Control
    private let controlEvents: UIControl.Event

    public init(
        control: Control,
        events: UIControl.Event
    ) {
        self.control = control
        self.controlEvents = events
    }

    public func receive<S>(
        subscriber: S
    ) where S: Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        let subscription = UIControlSubscription(
            subscriber: subscriber,
            control: control,
            event: controlEvents
        )
        subscriber.receive(subscription: subscription)
    }

    private class UIControlSubscription<
        SubscriberType: Subscriber, InnerControl: UIControl
    >: Subscription where SubscriberType.Input == InnerControl {
        private var subscriber: SubscriberType?
        private let control: InnerControl

        init(
            subscriber: SubscriberType,
            control: InnerControl,
            event: UIControl.Event
        ) {
            self.subscriber = subscriber
            self.control = control
            control.addTarget(self, action: #selector(eventHandler), for: event)
        }

        func request(
            _ demand: Subscribers.Demand
        ) { }

        func cancel() {
            subscriber = nil
        }

        @objc private func eventHandler() {
            _ = subscriber?.receive(control)
        }
    }
}
