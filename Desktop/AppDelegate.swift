//
//  AppDelegate.swift
//  Desktop
//
//  Created by Nghia Tran on 10/15/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Cocoa
import DesktopCore

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    // MARK: - Variable
    static var shared: AppDelegate {
        return NSApp.delegate as! AppDelegate
    }

    lazy var app: Application = {
        let urlSession = URLSession(configuration: .default)
        let networkService = NetworkService(fetcher: urlSession)
        let navigator = Navigator()
        let session = SessionManager()
        return Application(networkService: networkService,
                           navigator: navigator,
                           sessionManager: session)
    }()


    func applicationDidFinishLaunching(_ aNotification: Notification) {

        app.start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

