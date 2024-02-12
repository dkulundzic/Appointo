import UIKit

final class AddAppointmentViewController: StoreViewController<AddAppointmentFeature, AddAppointmentView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeStore()
    }
}

private extension AddAppointmentViewController {
    func setup() {
        // TODO: - Localize
        navigationItem.title = "Add Appointment"
        navigationItem.largeTitleDisplayMode = .never
    }

    func observeStore() {
        observe { [weak self] in
            guard let self else {
                return
            }
        }
    }
}
