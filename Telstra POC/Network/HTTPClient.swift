//
//  HTTPClient.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 19/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation

class HttpClient {
    typealias completeClosure = ( _ data: Data?,_ response: URLResponse?, _ error: Error?)->Void
    private let session: URLSession
    init(session: URLSession) {
        self.session = session
    }
    
    private static var sharedManager: HttpClient = {
        let apiManager = HttpClient(session: URLSession.shared)
        
        return apiManager
    }()
    
    // MARK: - Accessors
    
    class func shared() -> HttpClient {
        return sharedManager
    }


    func get( url: URL, callback: @escaping completeClosure ) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = session.dataTask(with: request) { (data, response, error) in
            callback(data, response, error)
        }
        task.resume()
    }
    
    func fetchCountryDetails(completionHandler: @escaping (Country?, String?) -> ()) {
        let url = APIManager.networkEnviroment.rawValue + EndPoints.fetchCountryDetails.rawValue
        get(url: URL(string: url)!) { (data, response, error) in
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
    }
    
}
