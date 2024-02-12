import UIKit

public extension UIView {
    func dropShadow(
        color: UIColor = .black,
        opacity: Float = 0.3,
        radius: CGFloat = 10.0
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
    }
}
