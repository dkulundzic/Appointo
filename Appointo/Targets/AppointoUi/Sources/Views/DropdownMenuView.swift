import UIKit
import SnapKit
import Combine

public protocol DropdownMenuViewItem: Hashable {
    var title: String { get }
}

open class DropdownMenuView<Item>: UIView where Item: DropdownMenuViewItem {
    @Published private var selectedItem: Item?
    private var bag = Set<AnyCancellable>()
    private let items: [Item]
    private let stackView = UIStackView()
    private let selectionButton = UIButton(type: .system)

    // TODO: - Localize
    private var noSelectionTitle: String {
        "No \(String(describing: Item.self).lowercased()) selected"
    }

    public init(
        items: [Item] = []
    ) {
        self.items = items
        super.init(frame: .zero)
        setupViews()
        setupObserving()
    }

    @available(*, unavailable)
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public extension DropdownMenuView {
    var itemSelection: AnyPublisher<Item?, Never> {
        $selectedItem.eraseToAnyPublisher()
    }
}

private extension DropdownMenuView {
    func setupObserving() {
        $selectedItem
            .sink { [weak self] item in
                UIView.performWithoutAnimation {
                    self?.selectionButton.setTitle(
                        item == nil ? self?.noSelectionTitle : item?.title, for: .normal
                    )

                    self?.selectionButton.setTitleColor(
                        item == nil ? .systemGray4 : .black, for: .normal
                    )
                }
            }
            .store(in: &bag)
    }

    func setupViews() {
        setupStackView()
        setupSelectionButton()
    }

    func setupStackView() {
        addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .leading
    }

    func setupSelectionButton() {
        addSubview(selectionButton)
        selectionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        selectionButton.contentHorizontalAlignment = .leading
        selectionButton.configuration = {
            var configuration: UIButton.Configuration = .plain()
            configuration.imagePlacement = .trailing
            configuration.titleAlignment = .leading
            configuration.contentInsets = .zero
            return configuration
        }()

        let actions: [UIMenuElement] = items
            .map { item in
                UIAction(
                    title: item.title
                ) { [weak self] _ in
                    self?.selectedItem = item
                }
            }

        selectionButton.menu = UIMenu(
            options: .displayInline,
            children: actions
        )
        selectionButton.showsMenuAsPrimaryAction = true
        selectionButton.changesSelectionAsPrimaryAction = true
    }
}
