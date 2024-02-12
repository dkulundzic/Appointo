import UIKit

open class Divider: UIView {
    public init() {
        super.init(frame: .zero)
        setupView()
    }

    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension Divider {
    func setupView() {
        snp.makeConstraints {
            $0.height.equalTo(0.5)
        }

        backgroundColor = .systemGray.withAlphaComponent(0.3)
    }
}
