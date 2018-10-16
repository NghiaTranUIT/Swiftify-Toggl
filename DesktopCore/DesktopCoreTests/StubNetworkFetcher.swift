//
//  StubNetworkFetcher.swift
//  DesktopCoreTests
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import Foundation
import DesktopCore
import XCTest
import RxSwift

class StubUserNetworkFetcher: NetworkFetcher {

    func fetch(with urlRequest: URLRequest, complete: @escaping (Data?, Error?) -> Void) {
        let jsonData = stubResponse(with: "User")
        complete(jsonData, nil)
    }
}

func stubResponse(with name: String) -> Data {
    class TestClass: NSObject {}
    let jsonURL = Bundle.init(for: TestClass.self).path(forResource: name, ofType: "json")!
    let jsonData = try! Data(contentsOf: URL(fileURLWithPath: jsonURL), options: Data.ReadingOptions.alwaysMapped)
    return jsonData
}
