import UIKit

class ViewController<View>: UIViewController where View: UIView {
    let specializedView: View = View()

    override func loadView() {
        view = specializedView
    }
}
