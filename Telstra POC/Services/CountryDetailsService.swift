//
//  CountryDetailsService.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
protocol CountryDetailsServiceProtocol : class {
    func fetchCountryDetails(_ completion: @escaping ((Result<Country, Error>) -> Void))
}

final class CountryDetailsService : CountryDetailsServiceProtocol {
    func fetchCountryDetails(_ completion: @escaping ((Result<Country, Error>) -> Void)) {
        
    }
    
    static let shared = CountryDetailsService()
    
    let endpoint = ""
    var task : URLSessionTask?

    
    // To cancel the task
    func cancelFetchCurrencies() {
        
        if let task = task {
            task.cancel()
        }
        task = nil
    }
}
