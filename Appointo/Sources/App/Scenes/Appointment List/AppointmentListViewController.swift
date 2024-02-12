import UIKit
import AppointoModel
import AppointoUi
import AppointoLocalization

final class AppointmentListViewController: StoreViewController<AppointmentListFeature, AppointmentListView> {
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
    }
}
