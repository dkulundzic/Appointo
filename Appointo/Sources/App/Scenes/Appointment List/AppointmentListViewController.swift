import UIKit
import Combine
import AppointoModel
import AppointoUi
import AppointoLocalization

final class AppointmentListViewController: StoreViewController<AppointmentListFeature, AppointmentListView> {
    private var bag = Set<AnyCancellable>()
    private lazy var dataSource = UITableViewDiffableDataSource<AppointmentListSection, Appointment>(
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
        store.send(
            .onAppointmentListItemTapped(
                indexPath
            )
        )
    }

    func tableView(
        _ tableView: UITableView,
        viewForHeaderInSection section: Int
    ) -> UIView? {
        let section = store.sections[section]
        let header = tableView.dequeueReusableHeader(
            AppointmentListSectionHeader.self
        )
        header.update(using: section.title)
        return header
    }
}

private extension AppointmentListViewController {
    func setup() {
        navigationItem.title = AppointoLocalizationStrings.appointmentListTitle
        navigationItem.largeTitleDisplayMode = .always

        dataSource.defaultRowAnimation = .fade

        specializedView.tableView.delegate = self
        specializedView.addAppointmentTapped = { [weak self] in
            self?.store.send(.onAddEditAppointmentButtonTapped)
        }
    }

    func observeStore() {
        observe { [weak self] in
            guard let self else { return }

            var snapshot = NSDiffableDataSourceSnapshot<AppointmentListSection, Appointment>()
            store.sections.forEach { section in
                snapshot.appendSections([section])
                snapshot.appendItems(
                    section.appointments, toSection: section
                )
            }

            dataSource.apply(
                snapshot, animatingDifferences: true
            )
        }

        store
            .scope(
                state: \.destination?.addAppointment,
                action: \.destination.addAppointment
            )
            .ifLet(
                then: { [weak self] store in
                    let addAppointment = UINavigationController(
                        rootViewController: AddEditAppointmentViewController(store: store)
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
