import UIKit
import Combine
import AppointoUi
import AppointoCore

final class AddAppointmentView: UIView {
    private let selectedDateSubject = PassthroughSubject<Date, Never>()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentContainerView = UIView()
    private let contentStackView = UIStackView()
    private let descriptionTextField = TextField()
    private let datePicker = UIDatePicker()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddAppointmentView {
    var datePublisher: AnyPublisher<Date, Never> {
        selectedDateSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension AddAppointmentView {
    @objc func dateSelected(
        _ datePicker: UIDatePicker
    ) {
        selectedDateSubject.send(
            datePicker.date
        )
    }
}

private extension AddAppointmentView {
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        setupScrollView()
        setupContentView()
        setupContentContainerView()
        setupContentStackView()
        setupDescriptionTextField()
        setupDatePicker()
    }

    func setupScrollView() {
        addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        scrollView.alwaysBounceVertical = true
    }

    func setupContentView() {
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(self)
        }
    }

    func setupContentContainerView() {
        contentView.addSubview(contentContainerView)
        contentContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(20)
            $0.height.greaterThanOrEqualTo(300)
        }
        contentContainerView.backgroundColor = .white
        contentContainerView.layer.cornerRadius = 16
    }

    func setupContentStackView() {
        contentContainerView.addSubview(contentStackView)
        contentStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.lessThanOrEqualToSuperview().inset(16)
        }
        contentStackView.axis = .vertical
        contentStackView.distribution = .fill
        contentStackView.alignment = .fill
        contentStackView.spacing = 8
    }

    func setupDescriptionTextField() {
        contentStackView.addArrangedSubview(
            FormFieldView(
                title: "Description",
                content: descriptionTextField
            )
        )

        // TODO: - Localize
        descriptionTextField.placeholder = "Appointment description"
    }

    func setupDatePicker() {
        contentStackView.addArrangedSubview(
            // TODO: - Localize
            FormFieldView(title: "Date", content: datePicker)
        )

        datePicker.preferredDatePickerStyle = .compact
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }
}

#Preview {
    AddAppointmentView()
}
