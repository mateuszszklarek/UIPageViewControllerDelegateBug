import UIKit

extension UIViewController {

    public func embed(_ childController: UIViewController, inside targetView: UIView) {
        embed(childController) { controllerView in
            targetView.addSubview(controllerView)
            controllerView.topAnchor.constraint(equalTo: targetView.topAnchor).isActive = true
            controllerView.leadingAnchor.constraint(equalTo: targetView.leadingAnchor).isActive = true
            controllerView.trailingAnchor.constraint(equalTo: targetView.trailingAnchor).isActive = true
            controllerView.bottomAnchor.constraint(equalTo: targetView.bottomAnchor).isActive = true
        }
    }

    public func embed(_ childController: UIViewController, using embeddingMethod: (UIView) -> Void) {
        addChild(childController)
        embeddingMethod(childController.view)
        childController.didMove(toParent: self)
    }

}
