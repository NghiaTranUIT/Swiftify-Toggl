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

public protocol ViewModelType {

    associatedtype Input
    associatedtype Output

    func transform(_ input: Input) -> Output
}

// MARK: - LoginViewModel
public final class LoginViewModel: ViewModelType {

    public struct Input {
        public let usernameVar: Observable<String>
        public let passwordVar: Observable<String>
        public let loginBtnAction: Observable<Void>

        public init(usernameVar: Observable<String>, passwordVar: Observable<String>, loginBtnAction: Observable<Void>) {
            self.usernameVar = usernameVar
            self.passwordVar = passwordVar
            self.loginBtnAction = loginBtnAction
        }
    }

    public struct Output {
        public let loginEnableDriver: Driver<Bool>
        public let loginSuccess: Observable<Result<User>>
    }

    // MARK: - Variable
    private let networkService: NetworkServiceType
    private let bag = DisposeBag()

    // MARK: - Init
    public init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    public func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output {
        let credentialObs = Observable.combineLatest(input.usernameVar, input.passwordVar) { return ($0, $1) }
        let loginSuccess =
            input.loginBtnAction
            .throttle(0.3, scheduler: MainScheduler.instance)
            .withLatestFrom(credentialObs)
            .flatMap {[unowned self] credential -> Observable<Result<User>> in
                let route = APIRoute.login(credential.0, credential.1)
                return self.networkService
                    .request(route, modelType: User.self)
            }

        let loginEnableDriver = Observable.combineLatest(input.usernameVar.asObservable(), input.passwordVar.asObservable())
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .asDriver(onErrorJustReturn: false)

        return Output(loginEnableDriver: loginEnableDriver, loginSuccess: loginSuccess)
    }
}
