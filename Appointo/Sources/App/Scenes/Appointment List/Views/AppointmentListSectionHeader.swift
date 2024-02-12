import UIKit
import AppointoUi

final class AppointmentListSectionHeader: UITableViewHeaderFooterView {
    private let titleLabel = UILabel()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppointmentListSectionHeader: UpdateableView {
    func update(
        using viewModel: ViewModel
    ) {
        titleLabel.text = viewModel
    }

    typealias ViewModel = String
}

private extension AppointmentListSectionHeader {
    func setupViews() {
        setupTitleLabel()
    }

    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(8)
            $0.leading.equalToSuperview().inset(8)
            $0.trailing.lessThanOrEqualToSuperview().inset(8)
        }
        titleLabel.font = .preferredFont(
            forTextStyle: .caption1
        )
        titleLabel.textColor = .darkGray
    }
}
