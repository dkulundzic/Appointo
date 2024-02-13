import UIKit
import AppointoModel
import AppointoUi
import AppointoLocalization

public struct AppointmentListCellProvider: CellProvider {
    public typealias Item = Appointment
    public typealias Cell = AppointmentListCell

    private static let timeFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        return formatter
    }()

    public func provideCell(
        for tableView: UITableView,
        indexPath: IndexPath,
        item: Appointment
    ) -> AppointmentListCell {
        let cell = tableView.dequeueReusableCell(
            AppointmentListCell.self, for: indexPath
        )

        let formattedTime = Self.timeFormatter.string(
            from: item.date
        )

        cell.update(
            using: .init(
                title: item.description,
                subtitle: AppointoLocalizationStrings
                    .appointmentListItemCellSubtitleFormat(
                        item.location.title,
                        formattedTime
                    )
            )
        )

        return cell
    }
}
