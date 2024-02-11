import Foundation
import Combine

public protocol AppointmentRepository: Repository { }

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
        guard !objectsSubject.value.contains(object) else {
            return
        }

        Task {
            objectsSubject.value.append(
                object
            )
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