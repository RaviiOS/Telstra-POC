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
                switch response.result {
                case .success(let string):
                    let country = string.parse(to: Country.self)
                    completionHandler(country, nil)
                case .failure(let error):
                    completionHandler(nil, error)
                }
                
        }
    }
    
    func fetchCountryDetails(completionHandler: @escaping (Country?, String?) -> ()) {
        let url = APIManager.networkEnviroment.rawValue + EndPoints.fetchCountryDetails.rawValue
        let session = URLSession.shared
        let task = session.dataTask(with: URL(string: url)!) { (data, response, error) in
            let statusCode = (response as! HTTPURLResponse).statusCode
            if statusCode == 200 {
                guard let data = data else {
                    completionHandler(nil, "Not able to parse the data!")
                    return
                }
                let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
                guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let country = try decoder.decode(Country.self, from: modifiedDataInUTF8Format)
                    DispatchQueue.main.async {
                        completionHandler(country, nil)
                    }
                } catch let error{
                    completionHandler(nil, error.localizedDescription)
                }
            }else{
                completionHandler(nil, error?.localizedDescription)
            }
        }
        task.resume()
    }
}
