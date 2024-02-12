import UIKit
import SnapKit
import AppointoUi
import AppointoCore

final class AppointmentListView: UIView {
    var addAppointmentTapped: Action?

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

private extension AppointmentListView {
    func setupViews() {
        setupTableView()
        setupAddAppointmentButton()
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        tableView.backgroundColor = .systemGroupedBackground
        tableView.alwaysBounceVertical = true
        tableView.contentInset = .init(top: 20)
        tableView.registerReusableCell(AppointmentListCell.self)
    }

    func setupAddAppointmentButton() {
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
