import UIKit

public extension UITableView {
    func registerReusableCell<Cell>(
        _ type: Cell.Type
    ) where Cell: ReusableView, Cell: UITableViewCell {
        self.register(type, forCellReuseIdentifier: "")
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
}
