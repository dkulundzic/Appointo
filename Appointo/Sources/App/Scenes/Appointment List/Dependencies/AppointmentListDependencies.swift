import ComposableArchitecture

private enum AppointmentListSectionVendorKey: DependencyKey {
    static var liveValue: AppointmentListSectionVendor = DefaultAppointmentListSectionVendor()
}

extension DependencyValues {
    var appointmentListSectionVendor: any AppointmentListSectionVendor {
        get { self[AppointmentListSectionVendorKey.self] }
        set { self[AppointmentListSectionVendorKey.self] = newValue }
    }
}
