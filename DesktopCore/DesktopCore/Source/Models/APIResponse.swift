//
//  APIResponse.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

struct APIResponse<T: Serializable> {

    let since: TimeInterval
    let data: T
}

extension APIResponse: Serializable {

    static func serialize(_ json: [String : Any]) -> APIResponse<T>? {
        guard let since = json["since"] as? TimeInterval,
        let dataJSON = json["data"] as? [String: Any],
            let data = T.serialize(dataJSON) else { return nil }
        return APIResponse<T>(since: since, data: data)
    }
}
