import UIKit
import SnapKit
import AppointoUi

final class AppointmentListView: UIView {
    let tableView = UITableView(
        frame: .zero,
        style: .insetGrouped
    )

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
}

#Preview {
    AppointmentListView()
}
