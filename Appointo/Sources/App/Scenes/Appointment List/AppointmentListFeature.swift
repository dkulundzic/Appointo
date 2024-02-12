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

            case .onAppointmentsLoaded(let appointments):
                state.appointments = .init(
                    uniqueElements: appointments
                )
                return .none

            case .onAddAppointmentButtonTapped:
                state.destination = .addAppointment(.init())
                return .none

            case .destination(_):
                print(#function)
                return .none
            }
        }
        .ifLet(
            \.$destination,
             action: \.destination
        ) {
            Destination()
        }
    }

    @ObservableState
    struct State: Equatable {
        @Presents var destination: Destination.State?
        var appointments: IdentifiedArrayOf<Appointment> = []
    }

    @Reducer
    struct Destination {
        @ObservableState
        enum State: Equatable {
            case addAppointment(AddAppointmentFeature.State)
        }

        enum Action {
            case addAppointment(AddAppointmentFeature.Action)
        }

        var body: some ReducerOf<Self> {
            Scope(
                state: \.addAppointment,
                action: \.addAppointment
            ) {
                AddAppointmentFeature()
            }
        }
    }

    enum Action {
        case onViewAppeared
        case onAppointmentsLoaded(_ appointments: [Appointment])
        case onAddAppointmentButtonTapped
        case destination(PresentationAction<Destination.Action>)
    }
}
