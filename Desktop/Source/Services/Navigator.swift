//
//  Navigator.swift
//  Desktop
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import Cocoa
import DesktopCore

protocol NavigatorType {

    func navigate(to scene: Navigator.Scene, with transition: Navigator.Transition)
}

final class Navigator: NavigatorType {

    enum Scene {
        case login
        case project

        var viewController: NSViewController {
            switch self {
            case .login:
                let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
                let controller = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("LoginViewController")) as! LoginViewController
                let network = AppDelegate.shared.app.networkService
                controller.viewModel = LoginViewModel(networkService: network)
                return controller
            default:
                fatalError()
            }
        }
    }

    enum Transition {
        case present
        case showDetail(NSViewController)
    }

    func navigate(to scene: Scene, with transition: Transition) {

        let controller = scene.viewController

        switch transition {
        case .present:
            let storyboard = NSStoryboard(name: NSStoryboard.Name("Main"), bundle: nil)
            let windowController = storyboard.instantiateController(withIdentifier: NSStoryboard.SceneIdentifier("RootWindowController")) as! NSWindowController
            windowController.contentViewController = controller
            windowController.showWindow(self)
            NSApp.activate(ignoringOtherApps: true)
        default:
            break
        }
    }
}
