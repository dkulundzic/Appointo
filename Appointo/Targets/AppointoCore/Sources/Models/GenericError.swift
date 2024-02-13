import Foundation

public enum GenericError: Error {
    case unknown
    case other(Error)
}
