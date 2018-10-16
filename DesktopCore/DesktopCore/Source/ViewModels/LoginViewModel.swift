//
//  LoginViewModel.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

public protocol LoginViewModelType {

    var input: LoginViewModelInput { get }
    var output:LoginViewModelOutput { get }
}

public protocol LoginViewModelInput {

}

public protocol LoginViewModelOutput {

}

// MARK: - LoginViewModel
public final class LoginViewModel: LoginViewModelType, LoginViewModelInput, LoginViewModelOutput {

    public var input: LoginViewModelInput { return self }
    public var output: LoginViewModelOutput { return self }

    // MARK: - Init
    public init() {

    }

}
