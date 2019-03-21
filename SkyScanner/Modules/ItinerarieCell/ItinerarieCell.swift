import Foundation
import UIKit

class ItinerarieCell: UITableViewCell {
    
    let module: MVP<UIView, ItinerarieIO>
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        module = ItinerarieRouter.createModule()
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(module.view)
        module.view.translatesAutoresizingMaskIntoConstraints = false
        module.view.activateConstraintsToWrapSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        module.input.itinerarie = nil
    }
    
}
