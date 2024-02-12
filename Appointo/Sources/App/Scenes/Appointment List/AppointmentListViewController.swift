import UIKit
import Combine
import AppointoModel
import AppointoUi
import AppointoLocalization

final class AppointmentListViewController: StoreViewController<AppointmentListFeature, AppointmentListView> {
    private var bag = Set<AnyCancellable>()
    private lazy var dataSource = UITableViewDiffableDataSource(
        tableView: specializedView.tableView,
        cellProvider: AppointmentListCellProvider()
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        observeStore()
    }

    override func viewDidAppear(
        _ animated: Bool
    ) {
        super.viewDidAppear(animated)

        store.send(.onViewAppeared)
    }
}

extension AppointmentListViewController: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        // TODO: -
        print(#function)
    }
}

private extension AppointmentListViewController {
    func setup() {
        navigationItem.title = AppointoLocalizationStrings.appointmentListTitle
        navigationItem.largeTitleDisplayMode = .always

        specializedView.tableView.delegate = self
        specializedView.addAppointmentTapped = { [weak self] in
            self?.store.send(.onAddAppointmentButtonTapped)
        }
    }

    func observeStore() {
        observe { [weak self] in
            guard let self else { return }

            var snapshot = dataSource.snapshot()
            snapshot.deleteAllItems()
            snapshot.appendSections([0])
            snapshot.appendItems(store.appointments.elements)

            dataSource.apply(snapshot)
        }

        store
            .scope(
                state: \.destination?.addAppointment,
                action: \.destination.addAppointment
            )
            .ifLet(
                then: { [weak self] store in
                    let addAppointment = UINavigationController(
                        rootViewController: AddAppointmentViewController(store: store)
                    )
                    self?.present(addAppointment, animated: true)
                },
                else: { [weak self] in
                    self?.dismiss(animated: true)
                }
            )
            .store(in: &bag)
    }
}
