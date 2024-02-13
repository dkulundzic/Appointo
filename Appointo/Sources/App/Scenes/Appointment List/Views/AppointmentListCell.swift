import UIKit
import SnapKit
import AppointoUi

public final class AppointmentListCell: UITableViewCell {
    private let verticalStackView = UIStackView()
    private let horizontalStackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

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
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }

    public struct ViewModel {
        public let title: String
        public let subtitle: String

        public init(
            title: String,
            subtitle: String
        ) {
            self.title = title
            self.subtitle = subtitle
        }
    }

}

private extension AppointmentListCell {
    func setupViews() {
        setupView()
        setupVerticalStackView()
        setupTitleLabel()
        setupHorizontalStackView()
        setupSubtitleLabel()
    }

    func setupView() {
        selectionStyle = .none
    }

    func setupVerticalStackView() {
        contentView.addSubview(verticalStackView)
        verticalStackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        verticalStackView.spacing = 8
    }

    func setupTitleLabel() {
        verticalStackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.adjustsFontForContentSizeCategory = true
        titleLabel.font = .preferredFont(forTextStyle: .body)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
    }

    func setupHorizontalStackView() {
        verticalStackView.addArrangedSubview(horizontalStackView)
        horizontalStackView.axis = .horizontal
        horizontalStackView.distribution = .fill
        horizontalStackView.alignment = .leading
        horizontalStackView.spacing = 8
    }

    func setupSubtitleLabel() {
        horizontalStackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.font = .preferredFont(
            forTextStyle: .footnote
        )
        subtitleLabel.textColor = .lightGray
        subtitleLabel.adjustsFontForContentSizeCategory = true
    }
}
