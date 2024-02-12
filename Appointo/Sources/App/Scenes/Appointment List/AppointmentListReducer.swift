import ComposableArchitecture
import AppointoModel

@Reducer
struct AppointmentListReducer {
    @Dependency(\.appointmentRepository) private var appointmentRepository

    var body: some Reducer<State, Action> {
        Reduce { state, action in
            switch action {
            case .onViewAppeared:
                return .run { send in
                    await send(
                        .onAppointmentsLoaded(
                            try await appointmentRepository.load()
                        )
                    )
                }
            case .onAppointmentsLoaded(let appointments):
                state.appointments = appointments
                return .none
            }
        }
    }

    @ObservableState
    struct State: Equatable {
        var appointments: [Appointment] = []
    }

    enum Action {
        case onViewAppeared
        case onAppointmentsLoaded(_ appointments: [Appointment])
    }
}
