import Foundation

public final class StartupProcessService {
    public init() { }

    @discardableResult
    public func run(
        _ process: StartupProcess
    ) -> Self {
        process.run()
        return self
    }
}
