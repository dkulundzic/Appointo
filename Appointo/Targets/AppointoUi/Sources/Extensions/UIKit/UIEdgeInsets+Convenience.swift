import UIKit

public extension UIEdgeInsets {
    init(
        top: CGFloat? = nil,
        leading: CGFloat? = nil,
        bottom: CGFloat? = nil,
        trailing: CGFloat? = nil
    ) {
        self.init(
            top: top ?? 0,
            left: leading ?? 0,
            bottom: bottom ?? 0,
            right: trailing ?? 0
        )
    }
}
