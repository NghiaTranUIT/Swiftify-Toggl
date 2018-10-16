//
//  NetworkServiceTests.swift
//  DesktopCoreTests
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import XCTest
import RxSwift
@testable import DesktopCore

class NetworkServiceTests: XCTestCase {

    private let bag = DisposeBag()

    override func setUp() {

    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAuthenticationSuccess() {

        // Given
        let fullname = "John Doe"
        let network = NetworkService(fetcher: StubUserNetworkFetcher())

        // When
        let obs = network.request(APIRoute.login("Toggl", "123"), modelType: User.self)

        // Then
        obs.subscribe(onNext: { (result) in
            switch result {
            case .success(let user):
                XCTAssertEqual(user.fullname, fullname, "Authentication doens't match")
            default:
                XCTFail("Request Failed")
            }
        })
        .disposed(by: bag)
    }
}
