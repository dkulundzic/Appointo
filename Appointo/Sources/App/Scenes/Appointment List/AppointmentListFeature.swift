import ComposableArchitecture
import AppointoModel

@Reducer
struct AppointmentListFeature {
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

            case .onAddAppointmentButtonTapped:
                state.addAppointment = .init()
                return .none

            case .addAppointment(.presented(.save(_))):
                return .none
            
            case .addAppointment(.dismiss):
                return .none

            case .onAppointmentsLoaded(let appointments):
                state.appointments = .init(
                    uniqueElements: appointments
                )
                return .none
            }
        }
        .ifLet(
            \.$addAppointment, action: \.addAppointment
        ) {
            AddAppointmentFeature()
        }
    }

    @ObservableState
    struct State: Equatable {
        @Presents var addAppointment: AddAppointmentFeature.State?
        var appointments: IdentifiedArrayOf<Appointment> = []
    }

    enum Action {
        case onViewAppeared
        case onAppointmentsLoaded(_ appointments: [Appointment])
        case onAddAppointmentButtonTapped
        case addAppointment(PresentationAction<AddAppointmentFeature.Action>)
    }
}
