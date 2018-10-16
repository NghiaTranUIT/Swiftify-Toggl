//
//  UserTests.swift
//  DesktopCoreTests
//
//  Created by Nghia Tran on 10/16/18.
//  Copyright © 2018 com.nsproxy.proxy. All rights reserved.
//

import XCTest
@testable import DesktopCore

class UserTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserSerializationSuccess() {
        // Given
        let user = User(email: "john.doe@gmail.com", fullname: "John Doe")
        let data = stubResponse(with: "User")
        let json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any]

        // When
        let response = APIResponse<User>.serialize(json!)

        // Then
        XCTAssertNotNil(response?.data, "Response serialize is failed")
        XCTAssertEqual(response!.data, user)
    }
}
