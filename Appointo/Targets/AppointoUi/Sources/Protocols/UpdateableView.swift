import UIKit

public protocol UpdateableView: UIView {
    associatedtype ViewModel

    func update(
        using viewModel: ViewModel
    )
}
