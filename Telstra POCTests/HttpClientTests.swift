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

    // Asynchronous test: success fast, failure slow
    func testValidCallToiTunesGetsHTTPStatusCode200() {
      // given
        let urlString = APIManager.networkEnviroment.rawValue + EndPoints.fetchCountryDetails.rawValue
      let url =
        URL(string: urlString)
      // 1
      let promise = expectation(description: "Status code: 200")

      // when
      let dataTask = sut.dataTask(with: url!) { data, response, error in
        // then
        if let error = error {
          XCTFail("Error: \(error.localizedDescription)")
          return
        } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
          if statusCode == 200 {
            // 2
            promise.fulfill()
          } else {
            XCTFail("Status code: \(statusCode)")
          }
        }
      }
      dataTask.resume()
      // 3
      wait(for: [promise], timeout: 5)
    }


}
