import UIKit

final class AppointmentListViewController: StoreViewController<AppointmentListReducer, AppointmentListView> {
    override func viewDidAppear(
        _ animated: Bool
    ) {
        super.viewDidAppear(animated)

        store.send(.onViewAppeared)
    }
}
