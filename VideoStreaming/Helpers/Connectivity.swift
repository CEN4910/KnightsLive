//
//  Connectivity.swift
//  VideoStreaming
//
//  Created by Nikil on 11/01/18.
//  Copyright © 2018 Nikil. All rights reserved.
//

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
