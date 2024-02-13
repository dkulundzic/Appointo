import UIKit
import SnapKit
import AppointoUi
import AppointoCore
import AppointoLocalization

final class AppointmentListView: UIView {
    var addAppointmentTapped: Action?
    private let emptyListBackgroundView = EmptyStateBackgroundView()

    let tableView = UITableView(
        frame: .zero,
        style: .insetGrouped
    )

    private lazy var addAppointmentButton = FloatingButton(
        image: .init(
            systemName: "plus"
        )) { [weak self] in
            self?.addAppointmentTapped?()
        }

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppointmentListView {
    var isEmptyListBackgroundViewHidden: Bool {
        get { emptyListBackgroundView.isHidden }
        set { emptyListBackgroundView.isHidden = newValue }
    }
}

private extension AppointmentListView {
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        setupEmptyListBackgroundView()
        setupTableView()
        setupAddEditAppointmentButton()
    }

    func setupEmptyListBackgroundView() {
        addSubview(emptyListBackgroundView)
        emptyListBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        emptyListBackgroundView.update(
            using: .init(
                title: AppointoLocalizationStrings.appointmentListEmptyListBackgroundViewTitle,
                subtitle: AppointoLocalizationStrings.appointmentListEmptyListBackgroundViewSubtitle
            )
        )
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.alwaysBounceVertical = true
        tableView.backgroundColor = .clear
        tableView.contentInset = .init(top: 20)
        tableView.registerReusableCell(AppointmentListCell.self)
        tableView.registerReusableHeader(AppointmentListSectionHeader.self)
    }

    func setupAddEditAppointmentButton() {
        addSubview(addAppointmentButton)
        addAppointmentButton.snp.makeConstraints {
            $0.trailing.equalTo(safeAreaLayoutGuide).inset(16)
            $0.bottom.equalTo(safeAreaLayoutGuide).inset(16)
        }
    }
}

#Preview {
    AppointmentListView()
}
