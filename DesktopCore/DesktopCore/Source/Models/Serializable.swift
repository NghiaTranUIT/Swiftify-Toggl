//
//  Serializable.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

public protocol Serializable {

    static func serialize(_ json: [String: Any]) -> Self?
}
