import UIKit

class RootViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    init() {
        super.init(nibName: nil, bundle: nil)
    }

    private(set) lazy var pageController = UIPageViewController(transitionStyle: .scroll,
                                                                navigationOrientation: .vertical)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUpCurrentIndexLabel()
        setUpPageController()
        setUpInitialPage()
        pageController.dataSource = self
        pageController.delegate = self
    }

    // MARK: - UIPageViewControllerDataSource

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return (viewController as? PageController).flatMap { controller(atIndex: $0.index - 1) }
    }

    func pageViewController(_ pageViewController: UIPageViewController,
                            viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return (viewController as? PageController).flatMap { controller(atIndex: $0.index + 1) }
    }

    // MARK: - UIPageViewControllerDelegate

    public func pageViewController(_ pageViewController: UIPageViewController,
                                   willTransitionTo pendingViewControllers: [UIViewController]) {
        if let nextController = pendingViewControllers.last as? PageController {
            nextPageIndex = nextController.index
        }
    }

    public func pageViewController(_ pageViewController: UIPageViewController,
                                   didFinishAnimating finished: Bool,
                                   previousViewControllers: [UIViewController],
                                   transitionCompleted completed: Bool) {
        if finished && completed {
            currentPageIndex = nextPageIndex
        } else {
            nextPageIndex = currentPageIndex
        }
    }

    // MARK: - Private

    private var currentPageIndex: Int = 0 {
        didSet { label.text = "Current page index: \(currentPageIndex)" }
    }
    private var nextPageIndex: Int = 0

    private func setUpCurrentIndexLabel() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50).isActive = true
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

    private func setUpPageController() {
        embed(pageController) { childView in
            childView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(childView)
            childView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            childView.heightAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }

    private func setUpInitialPage() {
        let controllers = [controller(atIndex: 0)].compactMap { $0 }
        currentPageIndex = 0
        pageController.setViewControllers(controllers, direction: .forward, animated: false)
    }

    private func controller(atIndex index: Int) -> UIViewController? {
        let dict: [Int: UIColor] = [
            0: .green,
            1: .yellow,
            2: .red
        ]

        guard let color = dict[index] else {
            return nil
        }

        return PageController(index: index, color: color)
    }

    private let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 25.0, weight: .bold)
        return label
    }()

    required init?(coder: NSCoder) { nil }

}

