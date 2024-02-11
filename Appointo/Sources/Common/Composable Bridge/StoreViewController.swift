import Combine
import ComposableArchitecture
import UIKit

/// Convenience class for view controllers that are powered by state stores.
class StoreViewController<Reducer, View>: ViewController<View> where Reducer: ComposableArchitecture.Reducer, View: UIView {
    let store: StoreOf<Reducer>

    init(
        store: StoreOf<Reducer>
    ) {
        self.store = store
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable) public required init?(coder: NSCoder) {
        fatalError("Not implemented")
    }
}
