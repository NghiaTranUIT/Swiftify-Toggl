//
//  LoginViewController.swift
//  Desktop
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Cocoa
import DesktopCore
import RxCocoa
import RxSwift

final class LoginViewController: NSViewController {

    // MARK: - OUTLET
    @IBOutlet weak var usernameTxt: NSTextField!
    @IBOutlet weak var passwordTxt: NSTextField!
    @IBOutlet weak var loginBtn: NSButton!

    // MARK: - Variable
    var viewModel: LoginViewModel!
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        binding()
    }

    private func binding() {
        let input = LoginViewModel.Input(usernameVar: usernameTxt.rx.text.asObservable().startWith("").flatMap { Observable.from(optional: $0) },
                                         passwordVar: passwordTxt.rx.text.asObservable().startWith("").flatMap { Observable.from(optional: $0) },
                                         loginBtnAction: loginBtn.rx.tap.asObservable())
        let output = viewModel.transform(input)

        output.loginEnableDriver
            .drive(loginBtn.rx.isEnabled)
            .disposed(by: bag)

        output.loginSuccess.drive(onNext: {[weak self] (success) in
            guard let strongSelf = self else { return }
            if success {
                let navigator = AppDelegate.shared.app.navigator
                navigator.navigate(to: .project, with: .present)
            }
        })
        .disposed(by: bag)
    }
}
