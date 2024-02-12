import Foundation
import ComposableArchitecture
import AppointoModel

@Reducer
struct AddAppointmentFeature {
    @Dependency(\.appointmentRepository) private var appointmentRepository

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .cancelButtonTapped:
                return .none

            case .saveButtonTapped:
                guard
                    let selectedLocation = state.selectedLocation
                else {
                    return .none
                }

                return .run { [date = state.selectedDate, description = state.description] send in
                    let appointment = Appointment(
                        date: date,
                        location: selectedLocation,
                        description: description
                    )

                    try await appointmentRepository.save(
                        appointment
                    )

                    await send(.appointmentSaved(appointment))
                }

            case .appointmentSaved:
                return .none

            case .descriptionChanged(let description):
                state.description = description
                state.validate()
                return .none

            case .dateSelected(let date):
                state.selectedDate = date
                state.validate()
                return .none

            case .locationSelected(let location):
                state.selectedLocation = location
                state.validate()
                return .none

            case .dismissed:
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

            validate()
        }

        mutating func validate() {
            let optionals: [Any?] = [selectedDate, selectedLocation]
            isFormValid = optionals.allSatisfy { $0 != nil } && !description.isEmpty
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
        }
    }

    enum Action {
        case saveButtonTapped
        case cancelButtonTapped
        case appointmentSaved(Appointment)
        case dateSelected(Date)
        case locationSelected(Location?)
        case descriptionChanged(String)
        case dismissed
    }
}
