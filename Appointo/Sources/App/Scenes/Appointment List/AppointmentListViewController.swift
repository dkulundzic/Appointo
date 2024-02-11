import UIKit

final class AppointmentListViewController: StoreViewController<AppointmentListReducer, AppointmentListView> {
    override func viewDidAppear(
        _ animated: Bool
    ) {
        super.viewDidAppear(animated)

        store.send(.onViewAppeared)
    }

    override func storeObservation(
        state: AppointmentListReducer.State
    ) {
        super.storeObservation(state: state)

        print("Store observed with state: \(state)")
    }
}
