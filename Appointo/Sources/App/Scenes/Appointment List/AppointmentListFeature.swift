import Foundation
import ComposableArchitecture
import AppointoModel

@Reducer
struct AppointmentListFeature {
    @Dependency(\.appointmentRepository) private var appointmentRepository
    @Dependency(\.appointmentListSectionVendor) private var sectionVendor

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

            case .onAddEditAppointmentButtonTapped:
                state.destination = .addAppointment(
                    .init(mode: .creation)
                )
                return .none

            case .onAppointmentListItemTapped(let indexPath):
                let appointment = state
                    .sections[indexPath.section]
                    .appointments[indexPath.row]

                state.destination = .addAppointment(
                    .init(
                        mode: .edit(appointment)
                    )
                )

                return .none

            case .destination(.presented(.addAppointment(.onDismissed))):
                state.destination = nil
                return .none
            
            case .destination(.presented(.addAppointment(.onAppointmentSaved))):
                state.destination = nil
                return .none

            case .destination(
                .presented(
                    .addAppointment(.onAppointmentDeletionResult(.success))
                )
            ):
                state.destination = nil
                return .none

            case .destination(.presented(.addAppointment(.onCancelButtonTapped))):
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
        var sections: [AppointmentListSection] = []
    }

    @Reducer
    struct Destination {
        @ObservableState
        enum State: Equatable {
            case addAppointment(AddEditAppointmentFeature.State)
        }

        enum Action {
            case addAppointment(AddEditAppointmentFeature.Action)
        }

        var body: some ReducerOf<Self> {
            Scope(
                state: \.addAppointment,
                action: \.addAppointment
            ) {
                AddEditAppointmentFeature()
            }
        }
    }

    enum Action {
        case onViewAppeared
        case onAppointmentsLoaded([Appointment])
        case onAddEditAppointmentButtonTapped
        case onAppointmentListItemTapped(IndexPath)
        case destination(PresentationAction<Destination.Action>)
    }
}
