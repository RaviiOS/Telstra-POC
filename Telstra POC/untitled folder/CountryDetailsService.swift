//
//  CountryDetailsService.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
protocol CountryDetailsServiceProtocol : class {
    func fetchCountryDetails(_ completion: @escaping ((Result<CountryDetails, ErrorResult>) -> Void))
}

final class CountryDetailsService : RequestHandler, CountryDetailsServiceProtocol {
    static let shared = CountryDetailsService()
    
    let endpoint = ""
    var task : URLSessionTask?

    func fetchCountryDetails(_ completion: @escaping ((Result<CountryDetails, ErrorResult>) -> Void)) {
        // cancel previous request if already in progress
        self.cancelFetchCurrencies()
        
        task = RequestService().loadData(urlString: endpoint, completion: self.networkResult(completion: completion))

    }
    
    // To cancel the task
    func cancelFetchCurrencies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
