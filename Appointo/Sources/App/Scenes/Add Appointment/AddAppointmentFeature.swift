import ComposableArchitecture
import AppointoModel

@Reducer
struct AddAppointmentFeature {
    @Dependency(\.appointmentRepository) private var appointmentRepository

    var body: some Reducer<State, Action> {
        Reduce { _, _ in
            .none
        }
    }

    @ObservableState
    struct State: Equatable { }

    enum Action {
        case saveButtonTapped
        case dismissed
    }
}
