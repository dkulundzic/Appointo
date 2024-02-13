import UIKit
import Combine
import ComposableArchitecture
import AppointoLocalization

final class AddEditAppointmentViewController: StoreViewController<AddEditAppointmentFeature, AddEditAppointmentView> {
    private var bag = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeStore()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        store.send(.onViewWillAppear)
    }
}

extension AddEditAppointmentViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(
        _ presentationController: UIPresentationController
    ) {
        store.send(.onDismissed)
    }
}

private extension AddEditAppointmentViewController {
    func setup() {
        setupNavigation()
        setupView()
    }

    func setupNavigation() {
        navigationItem.title = store.mode.isEditing ? AppointoLocalizationStrings.addAppointmentEditingTitle :
            AppointoLocalizationStrings.addAppointmentDefaultTitle
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = .init(
            systemItem: .cancel,
            primaryAction: .init { [weak self] _ in
                self?.store.send(.onCancelButtonTapped)
            }
        )
        navigationItem.rightBarButtonItem = .init(
            systemItem: .save,
            primaryAction: .init { [weak self] _ in
                self?.store.send(.onSaveButtonTapped)
            }
        )

        navigationController?.presentationController?.delegate = self
    }

    func setupView() {
        specializedView.appointmentDescription = store.description
        specializedView.location = store.selectedLocation
        specializedView.selectedDate = store.selectedDate

        specializedView.descriptionPublisher
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .sink { [weak self] description in
                self?.store.send(.onDescriptionChanged(description))
            }
            .store(in: &bag)

        specializedView.datePublisher
            .sink { [weak self] date in
                self?.store.send(.onDateSelected(date))
            }
            .store(in: &bag)

        specializedView.locationSelectionPublisher
            .sink { [weak self] location in
                self?.store.send(.onLocationSelected(location))
            }
            .store(in: &bag)
    }

    func observeStore() {
        observe { [weak self] in
            guard let self else {
                return
            }

            navigationItem
                .rightBarButtonItem?
                .isEnabled = store.isFormValid
        }
    }
}
