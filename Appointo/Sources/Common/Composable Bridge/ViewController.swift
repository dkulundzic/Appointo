import UIKit

class ViewController<View>: UIViewController where View: UIView {
    override func loadView() {
        view = View()
    }
}
