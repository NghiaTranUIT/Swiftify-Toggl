//
//  SessionManager.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import RxSwift

public protocol SessionManagerType {

    var state: Variable<SessionState> { get }
}

public enum SessionState {
    case invalid
    case valid(User)
}

public final class SessionManager: SessionManagerType {

    // MARK: - Variable
    public let state = Variable<SessionState>(.invalid)

    // MARK: - Init
    public init() {

    }
    
    // MARK: - Public
    public func setUser(_ user: User?) {
        guard let user = user else {
            state.value = .invalid
            return
        }
        state.value = .valid(user)
    }
}
