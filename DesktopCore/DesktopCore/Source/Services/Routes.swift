//
//  Routes.swift
//  DesktopCore
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation

protocol URLRequestConvertible {

    var urlRequest: URLRequest { get }
}

struct Header {

    let key: String
    let value: String
}

public enum APIRoute {

    case login(String, String)
    case fetchProjects

    var baseURL: String {
        return "https://www.toggl.com/api/v8"
    }

    var path: String {
        switch self {
        case .login:
            return "/me"
        case .fetchProjects:
            return "/projects"
        }
    }

    var headers: [Header] {
        var baseHeaders = [Header(key: "Content-Type", value: "application/json")]

        switch self {
        case .login(let username, let password):
            let info = "\(username):\(password)"
            let base64String = Data(info.utf8).base64EncodedString()
            baseHeaders.append(Header(key: "Authorization", value: "Basic \(base64String)"))
        default:
            break
        }
        return baseHeaders
    }

    var parameter: [String: Any]? {
        return nil
    }
}

extension APIRoute: URLRequestConvertible {

    var urlRequest: URLRequest {
        let fullPath = baseURL + path
        let url = URL(string: fullPath)!
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 60.0)

        headers.forEach {
            urlRequest.addValue($0.value, forHTTPHeaderField: $0.key)
        }

        return urlRequest
    }
}
