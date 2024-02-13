import Foundation
import ComposableArchitecture
import AppointoModel

@Reducer
struct AddEditAppointmentFeature {
    @Dependency(\.appointmentRepository) private var appointmentRepository
    @Dependency(\.addAppointmentFormValidator) private var formValidator

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onCancelButtonTapped:
                return .none

            case .onSaveButtonTapped:
                guard
                    let selectedLocation = state.selectedLocation
                else {
                    return .none
                }
                
                // swiftlint:disable closure_parameter_position
                return .run { [
                    date = state.selectedDate,
                    description = state.description,
                    editedApointmentId = state.mode.editedAppointment?.id
                ] send in
                    let appointment = Appointment(
                        id: editedApointmentId,
                        date: date,
                        location: selectedLocation,
                        description: description
                    )

                    try await appointmentRepository.save(
                        appointment
                    )

                    await send(.onAppointmentSaved(appointment))
                }
                // swiftlint:enable closure_parameter_position

            case .onAppointmentSaved:
                return .none

            case .onDescriptionChanged(let description):
                state.description = description
                state.validate(
                    using: formValidator
                )
                return .none

            case .onDateSelected(let date):
                state.selectedDate = date
                state.validate(
                    using: formValidator
                )
                return .none

            case .onLocationSelected(let location):
                state.selectedLocation = location
                state.validate(
                    using: formValidator
                )
                return .none

            case .onViewWillAppear:
                state.validate(
                    using: formValidator
                )
                return .none

            case .onDismissed:
                return .none
            }
        }
    }

    @ObservableState
    struct State: Equatable {
        var isFormValid = false
        var selectedDate: Date
        var selectedLocation: Location?
        var description: String
        let mode: Mode

        init(
            mode: Mode
        ) {
            self.mode = mode

            switch mode {
            case .creation:
                selectedDate = .now
                description = ""

            case .edit(let appointment):
                selectedDate = appointment.date
                selectedLocation = appointment.location
                description = appointment.description
            }
        }

        mutating func validate(
            using validator: some AddEditAppointmentFormValidator
        ) {
            isFormValid = validator.validate(
                description: description,
                selectedDate: selectedDate,
                selectedLocation: selectedLocation,
                in: mode
            )
        }

        enum Mode: Equatable {
            case creation
            case edit(Appointment)

            var isEditing: Bool {
                switch self {
                case .creation:
                    return false
                case .edit:
                    return true
                }
            }

            var editedAppointment: Appointment? {
                switch self {
                case .creation:
                    return nil
                case .edit(let appointment):
                    return appointment
                }
            }
        }
    }

    enum Action {
        case onSaveButtonTapped
        case onCancelButtonTapped
        case onAppointmentSaved(Appointment)
        case onDateSelected(Date)
        case onLocationSelected(Location?)
        case onDescriptionChanged(String)
        case onViewWillAppear
        case onDismissed
    }
}
