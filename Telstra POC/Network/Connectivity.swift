//
//  Connectivity.swift
//  Telstra POC
//
//  Created by Ravi Kumar Yaganti on 19/07/20.
//  Copyright © 2020 RK. All rights reserved.
//

import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}
