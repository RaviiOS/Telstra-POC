//
//  APIManager.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Alamofire

enum NetworkEnvironment: String {
    case dev = "https://dl.dropboxusercontent.com"
    case production = " "
    case stage = ""
}

enum EndPoints: String {
    case fetchCountryDetails = "/s/2iodh4vg0eortkl/facts.json"
}

class APIManager {
    
    // MARK: - Vars & Lets
    
    static let networkEnviroment: NetworkEnvironment = .dev
        
    private static var sharedApiManager: APIManager = {
        let apiManager = APIManager()
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> APIManager {
        return sharedApiManager
    }
        
    func getCountryDetails(completionHandler: @escaping (Country?, AFError?) -> ()) {
        let url = APIManager.networkEnviroment.rawValue + EndPoints.fetchCountryDetails.rawValue
        AF.request(url, method: .get,parameters: nil, encoding: JSONEncoding.default)
            .responseString { (response) in
                print(response)
                switch response.result {
                case .success(let string):
                    let country = string.parse(to: Country.self)
                    completionHandler(country, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
                
        }
    }
}
