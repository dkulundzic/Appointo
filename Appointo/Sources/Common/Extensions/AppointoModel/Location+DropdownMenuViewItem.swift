import AppointoModel
import AppointoUi

extension Location: DropdownMenuViewItem {
    public var title: String {
        name
    }
}
