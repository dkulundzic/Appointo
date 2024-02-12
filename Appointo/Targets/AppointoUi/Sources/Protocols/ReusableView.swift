import UIKit

public protocol ReusableView {
    static var reusableIdentifier: String { get }
}

public extension ReusableView {
    static var reusableIdentifier: String {
        String(describing: Self.self)
    }
}
