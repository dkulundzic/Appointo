import ComposableArchitecture

@Reducer
struct AppointmentListReducer {
    @ObservableState
    struct State: Equatable {
        var name = ""
    }

    enum Action {
        case onViewAppeared
    }

    var body: some Reducer<State, Action> {
        Reduce { _, action in
            switch action {
            case .onViewAppeared:
                return .none
            }
        }
    }
}
