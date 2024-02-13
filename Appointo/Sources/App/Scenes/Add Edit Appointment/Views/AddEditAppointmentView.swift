import UIKit
import Combine
import AppointoUi
import AppointoCore
import AppointoModel
import AppointoLocalization

final class AddEditAppointmentView: UIView {
    private var deleteButtonFormField: FormFieldView?
    private let selectedDateSubject = PassthroughSubject<Date, Never>()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentContainerView = UIView()
    private let contentStackView = UIStackView()
    private let descriptionTextField = UITextField()
    private let datePicker = UIDatePicker()
    private let locationDropdownView = DropdownMenuView(items: Location.allCases)
    private let deleteButton = UIButton()

    init() {
        super.init(frame: .zero)
        setupViews()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AddEditAppointmentView {
    var isDeleteButtonHidden: Bool {
        get { deleteButtonFormField?.isHidden ?? true }
        set { deleteButtonFormField?.isHidden = newValue }
    }

    var appointmentDescription: String? {
        get { descriptionTextField.text }
        set { descriptionTextField.text = newValue }
    }

    var selectedDate: Date {
        get { datePicker.date }
        set { datePicker.date = newValue }
    }

    var location: Location? {
        get { locationDropdownView.selectedItem }
        set { locationDropdownView.selectedItem = newValue }
    }

    var descriptionPublisher: AnyPublisher<String, Never> {
        descriptionTextField.textPublisher
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var datePublisher: AnyPublisher<Date, Never> {
        selectedDateSubject
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var locationSelectionPublisher: AnyPublisher<Location?, Never> {
        locationDropdownView.$selectedItem
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }

    var deleteButtonTapPublisher: AnyPublisher<UIButton, Never> {
        deleteButton
            .publisher(for: .touchUpInside)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

private extension AddEditAppointmentView {
    @objc func dateSelected(
        _ datePicker: UIDatePicker
    ) {
        selectedDateSubject.send(
            datePicker.date
        )
    }
}

private extension AddEditAppointmentView {
    func setupViews() {
        backgroundColor = .systemGroupedBackground
        setupScrollView()
        setupContentView()
        setupContentContainerView()
        setupContentStackView()
        setupDescriptionTextField()
        setupDatePicker()
        setupLocationDropdownView()
        setupDeleteButton()
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
        datePicker.addTarget(
            self, action: #selector(dateSelected), for: .valueChanged
        )
    }

    func setupLocationDropdownView() {
        contentStackView.addArrangedSubview(
            FormFieldView(
                title: AppointoLocalizationStrings.addAppointmentFormFieldLocationTitle,
                content: locationDropdownView
            )
        )
    }

    func setupDeleteButton() {
        let deleteButtonFormField = FormFieldView(
            title: nil,
            content: deleteButton
        )
        self.deleteButtonFormField = deleteButtonFormField
        contentStackView.addArrangedSubview(deleteButtonFormField)

        deleteButton.contentHorizontalAlignment = .leading
        deleteButton.role = .destructive
        deleteButton.configuration = {
            var configuration = UIButton.Configuration.plain()
            // TODO: - Localize
            configuration.title = "Delete appointment"
            configuration.imagePlacement = .trailing
            configuration.baseForegroundColor = .systemRed
            configuration.contentInsets = .zero
            return configuration
        }()
    }
}

#Preview {
    AddEditAppointmentView()
}
