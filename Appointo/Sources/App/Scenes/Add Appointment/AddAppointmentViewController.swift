import UIKit
import ComposableArchitecture

final class AddAppointmentViewController: StoreViewController<AddAppointmentFeature, AddAppointmentView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeStore()
    }
}

extension AddAppointmentViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(
        _ presentationController: UIPresentationController
    ) {
        store.send(.dismissed)
    }
}

private extension AddAppointmentViewController {
    func setup() {
        // TODO: - Localize
        navigationItem.title = "Add Appointment"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.rightBarButtonItem = .init(
            systemItem: .save,
            primaryAction: .init { [weak self] _ in
                self?.store.send(.saveButtonTapped)
            }
        )

        navigationController?.presentationController?.delegate = self
    }

    func observeStore() {
        observe { [weak self] in
            guard let self else {
                return
            }
        }
    }
}
