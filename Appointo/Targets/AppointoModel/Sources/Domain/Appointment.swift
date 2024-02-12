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

    public init(
        date: Date,
        location: Location,
        description: String
    ) {
        self.date = date
        self.location = location
        self.description = description
    }

    public func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(id)
    }
}
