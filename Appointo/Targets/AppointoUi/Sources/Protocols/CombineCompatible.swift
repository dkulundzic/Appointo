import Foundation
import UIKit

public protocol CombineCompatibleControl { }

public extension CombineCompatibleControl where Self: UIControl {
    func publisher(
        for events: UIControl.Event
    ) -> UIControlPublisher<Self> {
        UIControlPublisher(
            control: self,
            events: events
        )
    }
}

extension UIControl: CombineCompatibleControl { }
