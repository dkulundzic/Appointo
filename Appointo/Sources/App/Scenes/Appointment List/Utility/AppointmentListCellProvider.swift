import UIKit
import AppointoModel
import AppointoUi

public struct AppointmentListCellProvider: CellProvider {
    public typealias Item = Appointment
    public typealias Cell = AppointmentListCell

    public func provideCell(
        for tableView: UITableView,
        indexPath: IndexPath,
        item: Appointment
    ) -> AppointmentListCell {
        let cell = tableView.dequeueReusableCell(
            AppointmentListCell.self, for: indexPath
        )

        cell.update(
            using: .init(
                description: item.description
            )
        )

        return cell
    }
}
