import UIKit

class MVP<View, Input> {
    let view: View
    let input: Input
    
    init(view: View, input: Input) {
        self.view = view
        self.input = input
    }
}
