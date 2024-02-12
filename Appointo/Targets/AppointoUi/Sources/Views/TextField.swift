import UIKit

open class TextField: UITextField {
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.insetBy(dx: 8, dy: 8)
    }

    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        textRect(forBounds: bounds)
    }
}
