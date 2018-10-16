//
//  LoginViewModel.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public protocol LoginViewModelType {

    var input: LoginViewModelInput { get }
    var output:LoginViewModelOutput { get }
}

public protocol LoginViewModelInput {

    var usernameVar: Variable<String> { get }
    var passwordVar: Variable<String> { get }

    var loginBtnAction: PublishSubject<Void> { get }
}

public protocol LoginViewModelOutput {

    var loginEnableDriver: Driver<Bool> { get }
    var loginSuccess: Driver<Bool> { get }
}

// MARK: - LoginViewModel
public final class LoginViewModel: LoginViewModelType, LoginViewModelInput, LoginViewModelOutput {

    public var input: LoginViewModelInput { return self }
    public var output: LoginViewModelOutput { return self }

    // MARK: - Variable
    private let networkService: NetworkServiceType

    // MARK: - Input
    public let usernameVar = Variable<String>("")
    public let passwordVar = Variable<String>("")
    public let loginBtnAction = PublishSubject<Void>()

    // MARK: - Output
    public let loginEnableDriver: Driver<Bool>
    public var loginSuccess: Driver<Bool>

    // MARK: - Init
    public init(networkService: NetworkServiceType) {
        self.networkService = networkService

        // Binding
        loginSuccess = loginBtnAction
            .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest { _ -> Observable<Result<User>> in
                let route = APIRoute.login(self.usernameVar.value,
                                           self.passwordVar.value)
                return self.networkService
                    .request(route, modelType: User.self)
        }
            .map { return $0.isSuccess }
            .asDriver(onErrorJustReturn: false)
    }
}
