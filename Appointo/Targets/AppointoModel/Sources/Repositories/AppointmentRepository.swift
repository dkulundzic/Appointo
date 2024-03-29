import Foundation
import Combine

public protocol AppointmentRepository: Repository where Model == Appointment { }

public actor DefaultAppointmentRepository: AppointmentRepository {
    private let objectsSubject = CurrentValueSubject<[Appointment], Never>([])

    public nonisolated var changePublisher: AnyPublisher<[Appointment], Never> {
        objectsSubject.eraseToAnyPublisher()
    }

    public func load() async throws -> [Appointment] {
        await Task {
            objectsSubject.value
        }.value
    }

    public func save(
        _ object: Appointment
    ) async throws {
        Task {
            if let indexOf = objectsSubject.value.firstIndex(where: {
                $0.id == object.id
            }) {
                objectsSubject.value[indexOf] = object
            } else {
                objectsSubject.value.append(
                    object
                )
            }
        }
    }

    public func delete(
        id: UUID
    ) async throws {
        guard
            let indexOf = objectsSubject.value.firstIndex(where: {
                $0.id == id
            })
        else {
            return
        }

        Task {
            objectsSubject.value.remove(
                at: indexOf
            )
        }
    }
}

private extension DefaultAppointmentRepository {
    static var mock: [Model] {
        (1...10)
            .map { index in
                    .init(
                        date: Calendar.current.date(byAdding: .day, value: index % 2, to: .now) ?? Date(),
                        location: .allCases[3],
                        description: "Description #\(index)"
                    )
            }
    }
}
