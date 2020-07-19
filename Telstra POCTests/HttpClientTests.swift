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
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = URLSession(configuration: .default)

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()

    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
//    func test_get_request_withURL() {
//        guard let url = URL(string: "https://mockurl") else {
//            fatalError("URL can't be empty")
//        }
//        httpClient.get(url: url) { (success, response) in
//            // Return data
//        }
//        // Assert
//    }

    
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
