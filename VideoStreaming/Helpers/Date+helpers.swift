//
//  Date+helpers.swift
//  VideoStreaming
//
//  Created by WEBC-Mac on 11/06/18.
//  Copyright © 2018 Nikil. All rights reserved.
//

import Foundation
extension Date {
    @nonobjc static var localFormatter: DateFormatter = {
        let dateStringFormatter = DateFormatter()
        dateStringFormatter.dateStyle = .medium
        dateStringFormatter.timeStyle = .medium
        return dateStringFormatter
    }()
    
    func localDateString() -> String
    {
        return Date.localFormatter.string(from: self)
    }
}
