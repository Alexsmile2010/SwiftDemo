//
//  BaseNavigationController.swift
//  Blockster
//
//  Created by Vladimir Bukovskyi on 28.06.2021.
//

import Foundation
import UIKit

class BaseNavigationViewController: UINavigationController {
    
    private var isEnableBackSwipe: Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    
    private func setUpView() {
        self.isNavigationBarHidden = true
        self.interactivePopGestureRecognizer?.delegate = self
    }
}

//MARK: Public functions
extension BaseNavigationViewController {
    
    func enableBackSwipe(_ enable: Bool) {
        isEnableBackSwipe = enable
    }
    
    /// back to some count controllers ago
    func popBack(count: Int, animated: Bool = true) {
        if viewControllers.count < (count + 1) {
            return
        }
        self.popToViewController(viewControllers[viewControllers.count - (count + 1)], animated: animated)
    }
    
    /// back to specific controller
    func popBack<T: UIViewController>(toControllerType: T.Type, animated: Bool = true) {
        let viewControllers = viewControllers.reversed()
        for currentViewController in viewControllers {
            if currentViewController .isKind(of: toControllerType) {
                self.navigationController?.popToViewController(currentViewController, animated: animated)
                break
            }
        }
    }
}

extension BaseNavigationViewController {
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
    }
}

extension BaseNavigationViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if isEnableBackSwipe == false {
            return false
        }
        guard gestureRecognizer == interactivePopGestureRecognizer else {
            return true // default value
        }

        return viewControllers.count > 1
    }
}
