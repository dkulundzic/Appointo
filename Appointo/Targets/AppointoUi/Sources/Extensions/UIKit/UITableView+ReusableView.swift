import UIKit

public extension UITableView {
    func registerReusableCell<Cell>(
        _ type: Cell.Type
    ) where Cell: ReusableView, Cell: UITableViewCell {
        self.register(type, forCellReuseIdentifier: Cell.reusableIdentifier)
    }

    func registerReusableHeader<Header>(
        _ type: Header.Type
    ) where Header: ReusableView, Header: UITableViewHeaderFooterView {
        self.register(type, forHeaderFooterViewReuseIdentifier: Header.reusableIdentifier)
    }

    func dequeueReusableCell<Cell>(
        _ type: Cell.Type,
        for indexPath: IndexPath
    ) -> Cell where Cell: ReusableView {
        guard 
            let typedCell = self.dequeueReusableCell(
                withIdentifier: type.reusableIdentifier,
                for: indexPath
            ) as? Cell
        else {
            fatalError("Error dequeuing cell. Has the cell been registered?")
        }

        return typedCell
    }

    func dequeueReusableHeader<Header>(
        _ type: Header.Type
    ) -> Header where Header: ReusableView {
        guard
            let typedHeader = self.dequeueReusableHeaderFooterView(
                withIdentifier: Header.reusableIdentifier
            ) as? Header
        else {
            fatalError("Error dequeuing header. Has the header been registered?")
        }

        return typedHeader
    }
}

extension UITableViewCell: ReusableView { }

extension UITableViewHeaderFooterView: ReusableView { }
