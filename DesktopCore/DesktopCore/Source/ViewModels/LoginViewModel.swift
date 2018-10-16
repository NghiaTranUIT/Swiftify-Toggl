//
//  LoginViewModel.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

protocol LoginViewModelType {

    var input: LoginViewModelInput { get }
    var output:LoginViewModelOutput { get }
}

protocol LoginViewModelInput {

}

protocol LoginViewModelOutput {

}

// MARK: - LoginViewModel
final class LoginViewModel: LoginViewModelType, LoginViewModelInput, LoginViewModelOutput {

    var input: LoginViewModelInput { return self }
    var output: LoginViewModelOutput { return self }

    // MARK: - Init
    init() {

    }

}
