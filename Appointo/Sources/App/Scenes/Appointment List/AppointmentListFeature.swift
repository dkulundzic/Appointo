import Foundation
import ComposableArchitecture
import AppointoModel

@Reducer
struct AppointmentListFeature {
    @Dependency(\.appointmentRepository) private var appointmentRepository
    private let sectionVendor = AppointmentListSectionVendor()

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
                .merge(with: .publisher {
                    appointmentRepository.changePublisher
                        .receive(on: DispatchQueue.main)
                        .map {
                            .onAppointmentsLoaded($0)
                        }
                })

            case .onAppointmentsLoaded(let appointments):
                state.sections = sectionVendor.sections(for: appointments)
                return .none

            case .onAddAppointmentButtonTapped:
                state.destination = .addAppointment(
                    .init(mode: .creation)
                )
                return .none

            case .onAppointmentListItemTapped(let indexPath):
                let appointment = state.sections
                    .elements[indexPath.section]
                    .appointments[indexPath.row]

                state.destination = .addAppointment(
                    .init(
                        mode: .edit(appointment)
                    )
                )

                return .none

            case .destination(.presented(.addAppointment(.dismissed))):
                state.destination = nil
                return .none
            
            case .destination(.presented(.addAppointment(.saveButtonTapped))):
                state.destination = nil
                return .none

            case .destination(.presented(.addAppointment(.cancelButtonTapped))):
                state.destination = nil
                return .none

            case .destination:
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
        var sections: IdentifiedArrayOf<AppointmentListSection> = []
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
        case onAppointmentsLoaded([Appointment])
        case onAddAppointmentButtonTapped
        case onAppointmentListItemTapped(IndexPath)
        case destination(PresentationAction<Destination.Action>)
    }
}
