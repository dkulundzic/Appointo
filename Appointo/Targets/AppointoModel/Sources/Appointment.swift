import Foundation

public struct Appointment {
    public let id = UUID()
    public let date: Date
    public let location: Location
    public let description: String
}
