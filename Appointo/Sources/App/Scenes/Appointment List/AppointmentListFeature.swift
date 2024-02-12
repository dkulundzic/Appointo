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
                
            case .addAppointment(.presented(.saveButtonTapped)):
                state.addAppointment = nil
                return .none

            case .addAppointment(.presented(.dateSelected)):
                return .none

            case .addAppointment(.presented(.dismissed)):
                state.addAppointment = nil
                return .none

            case .addAppointment(.dismiss):
                state.addAppointment = nil
                return .none
                
            case .onAppointmentsLoaded(let appointments):
                state.appointments = .init(
                    uniqueElements: appointments
                )
                return .none
            }
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
