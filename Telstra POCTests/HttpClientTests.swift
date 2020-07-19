//
//  HttpClientTests.swift
//  Telstra POCTests
//
//  Created by Ravi Kumar Yaganti on 19/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import XCTest
@testable import Telstra_POC

class HttpClientTests: XCTestCase {
    var sut: URLSession!

    override func setUpWithError() throws {
        super.setUp()
        sut = URLSession(configuration: .default)

    }

    override func tearDownWithError() throws {
        sut = nil
        super.tearDown()

    }
    
    func testCountryDetailsAPI() {
        let urlString = APIManager.networkEnviroment.rawValue + EndPoints.fetchCountryDetails.rawValue
      let url =
        URL(string: urlString)
      let promise = expectation(description: "Completion handler invoked")
      var statusCode: Int?
      var responseError: Error?

      let dataTask = sut.dataTask(with: url!) { data, response, error in
        statusCode = (response as? HTTPURLResponse)?.statusCode
        responseError = error
        promise.fulfill()
      }
      dataTask.resume()
      wait(for: [promise], timeout: 5)

      XCTAssertNil(responseError)
      XCTAssertEqual(statusCode, 200)
    }
    
}
