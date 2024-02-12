import Foundation
import ComposableArchitecture
import AppointoModel

@Reducer
struct AddAppointmentFeature {
    @Dependency(\.appointmentRepository) private var appointmentRepository

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .saveButtonTapped:
                return .none

            case .dateSelected(let date):
                state.selectedDate = date
                return .none

            case .dismissed:
                return .none
            }
        }
    }

    @ObservableState
    struct State: Equatable {
        var selectedDate: Date?
    }

    enum Action {
        case saveButtonTapped
        case dateSelected(Date)
        case dismissed
    }
}
