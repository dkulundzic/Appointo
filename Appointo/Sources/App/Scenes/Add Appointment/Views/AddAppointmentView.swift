import UIKit
import AppointoUi

final class AddAppointmentView: UIView {
    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension AddAppointmentView {
    func setupViews() {
        backgroundColor = .white
    }
}
