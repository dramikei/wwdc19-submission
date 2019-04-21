import Foundation
import UIKit
class Braille: UIView {
    var isDark: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        //sets up view and turns the layer into a circle
        setupView()
        layer.cornerRadius = 12
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkGray.cgColor
        clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = UIColor.white
        
    }
}
