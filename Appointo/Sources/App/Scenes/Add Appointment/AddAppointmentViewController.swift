import UIKit
import Combine
import ComposableArchitecture
import AppointoLocalization

final class AddAppointmentViewController: StoreViewController<AddAppointmentFeature, AddAppointmentView> {
    private var bag = Set<AnyCancellable>()

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

    func presentationControllerShouldDismiss(
        _ presentationController: UIPresentationController
    ) -> Bool {
        store.isFormValid
    }
}

private extension AddAppointmentViewController {
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
                self?.store.send(.cancelButtonTapped)
            }
        )
        navigationItem.rightBarButtonItem = .init(
            systemItem: .save,
            primaryAction: .init { [weak self] _ in
                self?.store.send(.saveButtonTapped)
            }
        )

        navigationController?.presentationController?.delegate = self
    }

    func setupView() {
        specializedView.descriptionPublisher
            .sink { [weak self] description in
                self?.store.send(.descriptionChanged(description))
            }
            .store(in: &bag)

        specializedView.datePublisher
            .sink { [weak self] date in
                self?.store.send(.dateSelected(date))
            }
            .store(in: &bag)

        specializedView.locationSelectionPublisher
            .sink { [weak self] location in
                self?.store.send(.locationSelected(location))
            }
            .store(in: &bag)
    }

    func observeStore() {
        observe { [weak self] in
            guard let self else {
                return
            }

            navigationItem.rightBarButtonItem?.isEnabled = store.isFormValid

            specializedView.appointmentDescription = store.description
            specializedView.location = store.selectedLocation
            specializedView.selectedDate = store.selectedDate
        }
    }
}
