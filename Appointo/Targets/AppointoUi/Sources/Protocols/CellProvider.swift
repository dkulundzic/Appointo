import UIKit

public protocol CellProvider {
    associatedtype Item
    associatedtype Cell: UITableViewCell

    func provideCell(
        for tableView: UITableView,
        indexPath: IndexPath,
        item: Item
    ) -> Cell
}
