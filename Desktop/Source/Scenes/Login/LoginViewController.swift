//
//  LoginViewController.swift
//  Desktop
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Cocoa
import DesktopCore

final class LoginViewController: NSViewController {

    // MARK: - OUTLET
    @IBOutlet weak var usernameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSTextField!
    @IBOutlet weak var loginBtn: NSButton!

    // MARK: - Variable
    var viewModel: LoginViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
