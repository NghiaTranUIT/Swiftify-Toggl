//
//  LoginViewModelTests.swift
//  DesktopCoreTests
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import XCTest
import RxSwift

@testable import DesktopCore

class LoginViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel!
    private let bag = DisposeBag()

    override func setUp() {
        let network = NetworkService(fetcher: StubUserNetworkFetcher())
        viewModel = LoginViewModel(networkService: network)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginBtnEnableWhenUsernamePasswordAreValid() {

        // Given
        let usernameObs = Observable<String>.just("Toggl")
        let passwordObs = Observable<String>.just("password")
        let input = LoginViewModel.Input(usernameVar: usernameObs, passwordVar: passwordObs, loginBtnAction: .empty())

        // When
        let output = viewModel.transform(input)

        // Then
        output.loginEnableDriver.drive(onNext: { (enable) in
            XCTAssertTrue(enable)
        })
        .disposed(by: bag)
    }

    func testLoginBtnDisableWhenUsernamePasswordAreInvalid() {

        // Given
        let usernameObs = Observable<String>.just("")
        let passwordObs = Observable<String>.just("password")
        let input = LoginViewModel.Input(usernameVar: usernameObs, passwordVar: passwordObs, loginBtnAction: .empty())

        // When
        let output = viewModel.transform(input)

        // Then
        output.loginEnableDriver.drive(onNext: { (enable) in
            XCTAssertFalse(enable)
        })
            .disposed(by: bag)
    }

    func testLoginBtnGetSuccess() {

        // Given
        let usernameObs = Observable<String>.just("Toggl")
        let passwordObs = Observable<String>.just("password")
        let loginPublisher = PublishSubject<Void>()
        let loginObs = loginPublisher.asObserver()
        let input = LoginViewModel.Input(usernameVar: usernameObs, passwordVar: passwordObs, loginBtnAction: loginObs)

        // When
        let output = viewModel.transform(input)
        loginPublisher.onNext(())

        // Then
        output.loginSuccess.subscribe(onNext: { (result) in
            XCTAssertTrue(result.isSuccess)
        })
        .disposed(by: bag)
    }
}
