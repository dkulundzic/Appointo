import ComposableArchitecture

private enum AddAppointmentFormValidatorKey: DependencyKey {
    static var liveValue: AddAppointmentFormValidator = DefaultAddAppointmentFormValidator()
}

extension DependencyValues {
    var addAppointmentFormValidator: any AddAppointmentFormValidator {
        get { self[AddAppointmentFormValidatorKey.self] }
        set { self[AddAppointmentFormValidatorKey.self] = newValue }
    }
}
