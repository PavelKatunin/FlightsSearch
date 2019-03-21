import Foundation
import UIKit

struct SkyScannerStyle: Style {
    
    var titleFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 15)
    }
    
    var headingFont: UIFont {
        return UIFont.boldSystemFont(ofSize: 20)
    }
    
    var descriptionFont: UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    
    var titleColor: UIColor {
        return UIColor(white: 40.0 / 255.0, alpha: 1)
    }
    
    var descriptionColor: UIColor {
        return UIColor.lightGray
    }
    
    var labelColor: UIColor {
        return UIColor(displayP3Red: 0, green: 245.0 / 255.0, blue: 149.0 / 255.0, alpha: 1)
    }
    
    var labelFont: UIFont {
        return UIFont.systemFont(ofSize: 13)
    }
    
    var tintColor: UIColor {
        return UIColor(displayP3Red: 0, green: 179.0 / 255.0, blue: 214.0 / 255.0, alpha: 1)
    }
    
}
