import Foundation

public struct Appointment: Identifiable, Equatable, Hashable {
    public let id: UUID
    public let date: Date
    public let location: Location
    public let description: String

    public init(
        id: UUID? = nil,
        date: Date,
        location: Location,
        description: String
    ) {
        self.id = id ?? UUID()
        self.date = date
        self.location = location
        self.description = description
    }
}
