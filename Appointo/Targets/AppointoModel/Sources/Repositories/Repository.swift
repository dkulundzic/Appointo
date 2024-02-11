import Foundation
import Combine

public protocol Repository {
    associatedtype Model: Identifiable
    var changePublisher: AnyPublisher<[Model], Never> { get }
    func load() async throws -> [Model]
    func save(_ object: Model) async throws
    func delete(id: Model.ID) async throws
}
