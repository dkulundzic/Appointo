import Foundation

public struct Appointment: Identifiable, Equatable {
    public static func == (
        lhs: Appointment,
        rhs: Appointment
    ) -> Bool {
        lhs.id == rhs.id
    }

    public let id = UUID()
    public let date: Date
    public let location: Location
    public let description: String
}
