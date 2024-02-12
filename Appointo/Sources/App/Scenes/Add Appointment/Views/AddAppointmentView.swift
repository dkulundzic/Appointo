import UIKit
import Combine
import AppointoUi
import AppointoCore
import AppointoModel
import AppointoLocalization

final class AddAppointmentView: UIView {
    private let selectedDateSubject = PassthroughSubject<Date, Never>()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentContainerView = UIView()
    private let contentStackView = UIStackView()
    private let descriptionTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let locationDropdownView = DropdownMenuView(items: Location.allCases)

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
    var descriptionPublisher: AnyPublisher<String, Never> {
        descriptionTextField.textPublisher
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var datePublisher: AnyPublisher<Date, Never> {
        selectedDateSubject
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var locationSelectionPublisher: AnyPublisher<Location?, Never> {
        locationDropdownView.itemSelection
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
        setupLocationDropdownView()
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
                title: AppointoLocalizationStrings.addAppointmentFormFieldDescriptionTitle,
                content: descriptionTextField
            )
        )

        descriptionTextField.placeholder = AppointoLocalizationStrings.addAppointmentFormFieldDescriptionPlaceholder
    }

    func setupDatePicker() {
        contentStackView.addArrangedSubview(
            FormFieldView(
                title: AppointoLocalizationStrings.addAppointmentFormFieldDateTitle,
                content: datePicker
            )
        )

        datePicker.preferredDatePickerStyle = .compact
        datePicker.minuteInterval = 15
        datePicker.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
    }

    func setupLocationDropdownView() {
        contentStackView.addArrangedSubview(
            FormFieldView(
                title: AppointoLocalizationStrings.addAppointmentFormFieldLocationTitle,
                content: locationDropdownView
            )
        )
    }
}

#Preview {
    AddAppointmentView()
}
