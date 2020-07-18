//
//  HomeViewModel.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation
protocol HomeViewModelProtocol {
    
    var countryValueDidChanges: ((Bool, String) -> Void)? { get set }
    
    func fetchData()
}
class HomeViewModel: HomeViewModelProtocol {
    var countryValueDidChanges: ((Bool, String) -> Void)?
    
    //MARK: - Internal Properties
        
    var country: Country? {
        didSet {
            self.countryValueDidChanges!(true, country?.name ?? "")
        }
    }
    
    func fetchData() {
        APIManager.shared().getCountryDetails { (country, error) in
            guard let country = country else{
                debugPrint("Something went wrong ==>  \(error?.localizedDescription ?? "")")
                return
            }
            self.country = country
        }
    }
    
}
