import UIKit

public extension UITableViewDiffableDataSource where SectionIdentifierType == Int {
    convenience init<Provider>(
        tableView: UITableView,
        cellProvider: Provider
    ) where Provider: AppointoUi.CellProvider, Provider.Item == ItemIdentifierType {
        self.init(
            tableView: tableView
        ) { tableView, indexPath, item in
            cellProvider.provideCell(
                for: tableView,
                indexPath: indexPath,
                item: item
            )
        }
    }
}
