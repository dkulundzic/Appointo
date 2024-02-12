import UIKit

public final class FormFieldView: UIView {
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let contentView = UIView()
    private let divider = Divider()

    public init(
        title: String,
        content: UIView
    ) {
        super.init(frame: .zero)
        setupViews(
            title: title,
            content: content
        )
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FormFieldView {
    func setupViews(
        title: String,
        content: UIView
    ) {
        setupStackView()
        setupTitleLabel(with: title)
        setupContentView(with: content)
        setupDivider()
        stackView.setCustomSpacing(16, after: divider)
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
    }

    func setupTitleLabel(with title: String) {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.font = .preferredFont(
            forTextStyle: .caption1
        )
        titleLabel.text = title
    }

    func setupContentView(
        with content: UIView
    ) {
        stackView.addArrangedSubview(contentView)
        contentView.addSubview(content)
        content.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

    func setupDivider() {
        stackView.addArrangedSubview(divider)
    }
}
