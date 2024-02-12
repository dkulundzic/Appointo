import Foundation
import ComposableArchitecture
import AppointoModel

struct AppointmentListSectionVendor {
    private static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .none
        return formatter
    }()

    func sections(
        for appointments: [Appointment]
    ) -> IdentifiedArrayOf<AppointmentListSection> {
        let grouped = Dictionary(
            grouping: appointments
        ) { appointment in
            Calendar.current.dateComponents(
                [.year, .month, .day],
                from: appointment.date
            )
        }

        let sections = grouped
            .sorted {
                guard
                    let lhs = $0.key.day,
                    let rhs = $1.key.day
                else {
                    return true
                }

                return lhs < rhs
            }
            .compactMap { key, value -> AppointmentListSection? in
                guard
                    let date = Calendar.current.date(from: key)
                else {
                    return nil
                }

                return .init(
                    title: Self.formatter.string(from: date),
                    appointments: .init(
                        uniqueElements: value
                    )
                )
            }

        return .init(
            uniqueElements: sections
        )
    }
}
