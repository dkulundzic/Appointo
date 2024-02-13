import Foundation

public extension Result where Failure == GenericError {
    init(
        catching: () async throws -> Success
    ) async {
        do {
            self = .success(
                try await catching()
            )
        } catch let genericError as GenericError {
            self = .failure(genericError)
        } catch {
            self = .failure(.other(error))
        }
    }
}
