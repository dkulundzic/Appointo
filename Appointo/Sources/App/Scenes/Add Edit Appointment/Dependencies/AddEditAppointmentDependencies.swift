import ComposableArchitecture

private enum AddEditAppointmentFormValidatorKey: DependencyKey {
    static var liveValue: AddEditAppointmentFormValidator = DefaultAddEditAppointmentFormValidator()
}

extension DependencyValues {
    var addAppointmentFormValidator: any AddEditAppointmentFormValidator {
        get { self[AddEditAppointmentFormValidatorKey.self] }
        set { self[AddEditAppointmentFormValidatorKey.self] = newValue }
    }
}
