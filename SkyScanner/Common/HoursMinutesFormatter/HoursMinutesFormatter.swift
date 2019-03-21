import Foundation

class HoursMinutesFormatter {
    
    func stringFrom(minutesNumber: Int) -> String {
        let hours = minutesNumber / 60
        let minutes = minutesNumber % 60
        var strings = [String]()
        if hours > 0 { strings.append("\(hours)h")}
        if minutes > 0 { strings.append("\(minutes)m")}
        return strings.joined(separator: " ")
    }
    
}
