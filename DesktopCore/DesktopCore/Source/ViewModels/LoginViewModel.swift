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
        public let usernameVar: Variable<String>
        public let passwordVar: Variable<String>
        public let loginBtnAction: PublishSubject<Void>
    }

    public struct Output {
        public let loginEnableDriver: Driver<Bool>
        public let loginSuccess: Driver<Bool>
    }

    // MARK: - Variable
    private let networkService: NetworkServiceType

    // MARK: - Init
    public init(networkService: NetworkServiceType) {
        self.networkService = networkService
    }

    public func transform(_ input: LoginViewModel.Input) -> LoginViewModel.Output {

        let loginSuccess =
            input.loginBtnAction
            .throttle(0.3, scheduler: MainScheduler.instance)
            .flatMapLatest {[weak self] _ -> Observable<Result<User>> in
                guard let strongSelf = self else { return .empty() }
                let route = APIRoute.login(input.usernameVar.value,
                                           input.passwordVar.value)
                return strongSelf.networkService
                    .request(route, modelType: User.self)
            }
            .map { return $0.isSuccess }
            .asDriver(onErrorJustReturn: false)

        let loginEnableDriver = Observable.combineLatest(input.usernameVar.asObservable(), input.usernameVar.asObservable())
            .map { !$0.0.isEmpty && !$0.1.isEmpty }
            .asDriver(onErrorJustReturn: false)

        return Output(loginEnableDriver: loginEnableDriver, loginSuccess: loginSuccess)
    }
}
