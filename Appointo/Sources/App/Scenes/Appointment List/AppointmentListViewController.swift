import UIKit

final class AppointmentListViewController: StoreViewController<AppointmentListReducer, AppointmentListView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        observeStore()
    }

    override func viewDidAppear(
        _ animated: Bool
    ) {
        super.viewDidAppear(animated)

        store.send(.onViewAppeared)
    }
}

private extension AppointmentListViewController {
    func observeStore() {
        observe { [weak self] in
            guard let self else { return }

        }
    }
}
