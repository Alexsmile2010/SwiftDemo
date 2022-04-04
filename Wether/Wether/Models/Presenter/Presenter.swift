//
//  Presenter.swift
//  DGTX
//
//  Created by Alexey Zayakin on 23.03.2021.
//

import Foundation
import UIKit
import SafariServices

enum AppViewControllers {
    case welcome
    case main(MainViewControllerViewModel)
    case search
}

extension AppViewControllers {
    
    var modal: UIViewController {
        switch self {
        case .welcome:
            return WelcomeViewController()
        case .main(let viewModel):
            return MainViewController(with: viewModel)
        case .search:
            return SearchLocationViewController()
        }
    }
    
    var navigation: UINavigationController {
        return BaseNavigationViewController(rootViewController: modal)
    }
}


//MARK: - New Navigation system

struct ModalTransitionSettings {
    
    private let destinationType: AppViewControllers
    private let basedOnNavigatonController: Bool
    private let presentationStyle: UIModalPresentationStyle
    private let transitionStyle: UIModalTransitionStyle
    
    let animated: Bool
    
    var destinationViewController: UIViewController {
        let viewController = basedOnNavigatonController ? destinationType.navigation : destinationType.modal
        viewController.modalTransitionStyle = transitionStyle
        viewController.modalPresentationStyle = presentationStyle
        return viewController
    }
    
    init(destinationType: AppViewControllers,
         presentationStyle: UIModalPresentationStyle = .automatic,
         transitionStyle: UIModalTransitionStyle = .coverVertical,
         basedOnNavigatonController: Bool = false,
         animated: Bool = true) {
        
        self.destinationType = destinationType
        self.presentationStyle = presentationStyle
        self.transitionStyle = transitionStyle
        self.basedOnNavigatonController = basedOnNavigatonController
        self.animated = animated
    }
}

struct PushTransitionSettings {
    
    private let destinationType: AppViewControllers
    let hideBottomBarWhenPushed: Bool
    let animated: Bool
    
    var destinationViewController: UIViewController {
        let controller = destinationType.modal
        controller.hidesBottomBarWhenPushed = hideBottomBarWhenPushed
        return controller
    }
    
    init(destinationType: AppViewControllers,
         animated: Bool = true,
         hideBottomBarWhenPushed: Bool = false) {
        
        self.destinationType = destinationType
        self.animated = animated
        self.hideBottomBarWhenPushed = hideBottomBarWhenPushed
    }
}

struct RootTransitionSettings {
    
    private let destinationType: AppViewControllers
    private let basedOnNavigatonController: Bool
    
    var destinationViewController: UIViewController {
        basedOnNavigatonController ? destinationType.navigation : destinationType.modal
    }
    
    init(destinationType: AppViewControllers, basedOnNavigatonController: Bool = false) {
        self.basedOnNavigatonController = basedOnNavigatonController
        self.destinationType = destinationType
    }
}

struct OpenUrlTransitionSettings {
    
    let url: URL
    let insideApp: Bool
    
    init(url: URL, openInsideApp: Bool = true) {
        self.url = url
        self.insideApp = openInsideApp
    }
}

struct ShareTransitionSettings {
    
    let text: String?
    let url: URL?
    let image: UIImage?
    
    init(text: String?, url: URL?, image: UIImage?) {
        self.text = text
        self.url = url
        self.image = image
    }
}

struct AlertTransitionSettings {
    
    let title: LOCKey
    let message: LOCKey
    let actionTitle: LOCKey
    let cancelTitle: LOCKey
    let completeAction: (() -> Void)?
    
    init(title: LOCKey, message: LOCKey, actionTitle: LOCKey, cancelTitle: LOCKey, onComplete: (() -> Void)?) {
        self.title = title
        self.message = message
        self.actionTitle = actionTitle
        self.cancelTitle = cancelTitle
        self.completeAction = onComplete
    }
}

struct InfoAlertTransitionSettings {
    
    let message: LOCKey
    let actionTitle: LOCKey
    let completeAction: (() -> Void)?
    
    init(message: LOCKey, actionTitle: LOCKey, onComplete: (() -> Void)?) {
        self.message = message
        self.actionTitle = actionTitle
        self.completeAction = onComplete
    }
}

enum AppViewControllerNavigationType {
    case modal(settings: ModalTransitionSettings)
    case push(settings: PushTransitionSettings)
    case root(settings: RootTransitionSettings)
}

struct AppNavigation {
    
    private var window: UIWindow? {
        var window: UIWindow?
        for scene in UIApplication.shared.connectedScenes {
            if
                let currentScene = scene as? UIWindowScene,
                let delegate = currentScene.delegate as? UIWindowSceneDelegate,
                let currentWindow = delegate.window {
                window = currentWindow
                break
            }
        }
        
        return window
    }
    
    private var focusViewController: UIViewController? {
        if let presentedVC = window?.rootViewController?.presentedViewController {
            return presentedVC
        } else {
            return window?.rootViewController
        }
    }
    
    private var rootViewController: UIViewController? {
        return window?.rootViewController
    }
    
    private var navigationType: AppViewControllerNavigationType
    
    init(type: AppViewControllerNavigationType) {
        self.navigationType = type
    }
    
    func navigate() {
        DispatchQueue.main.async {
            switch navigationType {
            case .modal(let settings):
                presentModalViewController(with: settings)
            case .push(let settings):
                presentPushViewController(with: settings)
            case .root(let settings):
                presentRootViewController(with: settings)
            }
        }
    }
    
    private func presentModalViewController(with settings: ModalTransitionSettings) {
        focusViewController?.present(settings.destinationViewController,
                                     animated: settings.animated,
                                     completion: nil)
    }
    
    private func presentPushViewController(with settings: PushTransitionSettings) {
        if let navigationController = focusViewController as? UINavigationController {
            navigationController.pushViewController(settings.destinationViewController, animated: settings.animated)
        } else if
            let tabbarController = focusViewController as? UITabBarController,
            let navigationController = tabbarController.selectedViewController as? UINavigationController {
            navigationController.pushViewController(settings.destinationViewController, animated: settings.animated)
        }
    }
    
    private func presentRootViewController(with settings: RootTransitionSettings) {
        window?.rootViewController = settings.destinationViewController
    }
}


