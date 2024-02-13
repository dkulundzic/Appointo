import Foundation

public struct Location: Identifiable, Hashable {
    public static func == (
        lhs: Location,
        rhs: Location
    ) -> Bool {
        lhs.id == rhs.id
    }

    public let id: UUID
    public let name: String

    private init(
        id: UUID,
        name: String
    ) {
        self.id = id
        self.name = name
    }

    public func hash(
        into hasher: inout Hasher
    ) {
        hasher.combine(id)
    }
}

extension Location: CaseIterable {
    public static var allCases: [Self] {
        [
            .init(
                id: .init(
                    uuidString: "18fbafc5-e7d3-4a6c-a55c-9a77f03550b4"
                ) ?? UUID(),
                name: "San Diego"
            ),
            .init(
                id: .init(
                    uuidString: "f785c5d6-9667-4ce2-9c93-616ce871aa11"
                ) ?? UUID(),
                name: "St. George"
            ),
            .init(
                id: .init(
                    uuidString: "4546e0ad-a199-4997-956c-780f6c0c5039"
                ) ?? UUID(),
                name: "Park City"
            ),
            .init(
                id: .init(
                    uuidString: "de77c2ec-b365-498d-aade-1dd64e1059ef"
                ) ?? UUID(),
                name: "Dallas"
            ),
            .init(
                id: .init(
                    uuidString: "aa09f1b6-b63a-4ea5-a6a8-03da601b0a07"
                ) ?? UUID(),
                name: "Memphis"
            ),
            .init(
                id: .init(
                    uuidString: "aa09f1b6-b63a-4ea5-a6a8-03da601b0a07"
                ) ?? UUID(),
                name: "Orlando"
            )
        ]
    }
}
