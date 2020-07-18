//
//  CountryDetails.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 18/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Foundation

struct Country: Decodable {
   let name : String?
   let details : [CountryDetails]?

   enum CodingKeys: String, CodingKey {

       case name = "title"
       case details = "rows"
   }

   init(from decoder: Decoder) throws {
       let values = try decoder.container(keyedBy: CodingKeys.self)
       name = try values.decodeIfPresent(String.self, forKey: .name)
       details = try values.decodeIfPresent([CountryDetails].self, forKey: .details)
   }
}

