//
//  Date+Weekdays.swift
//  SkyScanner
//
//  Created by Pavel Katunin on 1/3/19.
//  Copyright © 2019 PavelKatunin. All rights reserved.
//

import Foundation

extension Date {
    
    public func next(_ weekday: Weekday,
                     direction: Calendar.SearchDirection = .forward,
                     considerToday: Bool = false) -> Date {
        let calendar = Calendar(identifier: .gregorian)
        let components = DateComponents(weekday: weekday.rawValue)
        
        if considerToday &&
            calendar.component(.weekday, from: self) == weekday.rawValue
        {
            return self
        }
        
        return calendar.nextDate(after: self,
                                 matching: components,
                                 matchingPolicy: .nextTime,
                                 direction: direction)!
    }
    
    public enum Weekday: Int {
        case sunday = 1, monday, tuesday, wednesday, thursday, friday, saturday
    }
    
}
