//
//  User.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

public struct User {

    fileprivate struct Constants {
        static let Email = "email"
        static let FullName = "fullname"
    }

    let email: String
    let fullname: String
}

extension User: Serializable {

    public static func serialize(_ json: [String : Any]) -> User? {
        guard let email = json[Constants.Email] as? String,
            let fullname = json[Constants.FullName] as? String else {
                return nil
        }
        return User(email: email,
                    fullname: fullname)
    }
}

extension User: Equatable {

    public static func == (lhs: User, rhs: User) -> Bool {
        if lhs.email == rhs.email &&
            lhs.fullname == rhs.fullname {
            return true
        }
        return false
    }
}
