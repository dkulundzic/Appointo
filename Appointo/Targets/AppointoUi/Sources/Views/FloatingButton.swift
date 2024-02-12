import UIKit
import AppointoCore

public class FloatingButton: UIView {
    private let button: UIButton
    private let defaultSize: CGSize = .init(width: 60, height: 60)

    public init(
        image: UIImage?,
        action: @escaping Action
    ) {
        button = UIButton(
            type: .system,
            primaryAction: .init(
                image: image,
                handler: { _ in
                    action()
                })
        )

        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
    }


}

private extension FloatingButton {
    func setupViews() {
        setupButton()
    }
    
    func setupButton() {
        addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.size.equalTo(defaultSize)
        }
        button.layer.cornerRadius = defaultSize.width / 2
        button.backgroundColor = .white
        button.dropShadow()
    }
}

#Preview {
    FloatingButton(
        image: UIImage(
            systemName: "plus"
        )
    ) { }
}
