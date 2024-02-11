import UIKit

public final class AppointmentListCell: UITableViewCell, UpdateableView {
    private let descriptionLabel = UILabel()

    public override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func update(
        using viewModel: ViewModel
    ) {
        descriptionLabel.text = viewModel.description
    }

    public struct ViewModel {
        public let description: String

        public init(
            description: String
        ) {
            self.description = description
        }
    }
}
