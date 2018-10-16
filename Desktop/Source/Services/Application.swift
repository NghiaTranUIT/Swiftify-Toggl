//
//  Application.swift
//  Desktop
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import DesktopCore
import RxSwift

final class Application {

    // MARK: - Variable
    let networkService: NetworkServiceType
    let navigator: NavigatorType
    let sessionManager: SessionManagerType
    private let bag = DisposeBag()

    // MARK: - Init
    init(networkService: NetworkServiceType, navigator: NavigatorType, sessionManager: SessionManagerType) {
        self.networkService = networkService
        self.navigator = navigator
        self.sessionManager = sessionManager
    }

    func start() {
        sessionManager.state.asDriver()
            .drive(onNext: {[weak self] (state) in
                guard let strongSelf = self else { return }
                switch state {
                case .invalid:
                    strongSelf.navigator.navigate(to: .login, with: .present)
                case .valid(let user):
                    strongSelf.navigator.navigate(to: .login, with: .present)
                }
            })
            .disposed(by: bag)
    }
}
