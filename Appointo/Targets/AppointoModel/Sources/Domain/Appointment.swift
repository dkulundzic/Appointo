import Foundation

public struct Appointment: Identifiable, Equatable, Hashable {
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

    public func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(id)
    }
}
