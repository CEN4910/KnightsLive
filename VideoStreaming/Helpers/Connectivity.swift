//
//  Connectivity.swift
//  VideoStreaming
//
//  Created by Emmanuel on 01/20/19.

import Foundation
import Alamofire
class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
