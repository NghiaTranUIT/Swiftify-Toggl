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
        static let Username = "username"
        static let FullName = "fullname"
    }

    let username: String
    let fullname: String
}

extension User: Serializable {

    public static func serialize(_ json: [String : Any]) -> User? {
        guard let username = json[Constants.Username] as? String,
            let fullname = json[Constants.FullName] as? String else {
                return nil
        }
        return User(username: username,
                    fullname: fullname)
    }
}
