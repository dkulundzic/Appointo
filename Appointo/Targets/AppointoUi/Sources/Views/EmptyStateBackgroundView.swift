import UIKit
import SnapKit

open class EmptyStateBackgroundView: UIView {
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()

    public init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension EmptyStateBackgroundView: UpdateableView {
    public func update(
        using viewModel: ViewModel
    ) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
    }

    public struct ViewModel {
        let title: String
        let subtitle: String

        public init(
            title: String,
            subtitle: String
        ) {
            self.title = title
            self.subtitle = subtitle
        }
    }
}

private extension EmptyStateBackgroundView {
    func setupViews() {
        setupStackView()
        setupTitleLabel()
        setupSubtitleLabel()
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 8
    }

    func setupTitleLabel() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.textColor = .darkGray
        titleLabel.font = .preferredFont(
            forTextStyle: .title3
        )
    }

    func setupSubtitleLabel() {
        stackView.addArrangedSubview(subtitleLabel)
        subtitleLabel.textColor = .systemGray
        subtitleLabel.font = .preferredFont(
            forTextStyle: .footnote
        )
    }
}
