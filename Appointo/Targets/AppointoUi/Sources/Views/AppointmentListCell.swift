import UIKit
import SnapKit

public final class AppointmentListCell: UITableViewCell {
    private let descriptionLabel = UILabel()

    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AppointmentListCell: UpdateableView {
    public func update(
        using viewModel: ViewModel
    ) {
        descriptionLabel.text = viewModel.description
    }

    public struct ViewModel {
        public let description: String

        public init(
            description: String
        ) {
            self.description = description
        }
    }

}

private extension AppointmentListCell {
    func setupViews() {
        setupView()
        setupDescriptionLabel()
    }

    func setupView() {
        selectionStyle = .none
    }

    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        descriptionLabel.textColor = .black
        descriptionLabel.adjustsFontForContentSizeCategory = true
        descriptionLabel.font = .preferredFont(forTextStyle: .body)
    }
}
