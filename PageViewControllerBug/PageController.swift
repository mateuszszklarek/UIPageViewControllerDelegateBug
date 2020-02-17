import UIKit

class PageController: UIViewController {

    let index: Int

    init(index: Int, color: UIColor) {
        self.index = index
        self.color = color
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { nil }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = color
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        label.text = "#\(index)"
    }

    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        return label
    }()

    // MARK: - Private

    private let color: UIColor

}
