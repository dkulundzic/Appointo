import ComposableArchitecture

private enum AppointmentRepositoryKey: DependencyKey {
    static var liveValue: any AppointmentRepository = DefaultAppointmentRepository()
}

public extension DependencyValues {
    var appointmentRepository: any AppointmentRepository {
        get { self[AppointmentRepositoryKey.self] }
        set { self[AppointmentRepositoryKey.self] = newValue }
    }
}
