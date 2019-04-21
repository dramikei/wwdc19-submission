import Foundation
import UIKit

class NextButton: UIButton {
    override func draw(_ rect: CGRect) {
        
        //Draws the circle
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 40, height: 40))
        UIColor.darkGray.setStroke()
        ovalPath.lineWidth = 2
        ovalPath.stroke()
        
        
        //Draws the ">" inside the circle
        let bezierPath = UIBezierPath()
        bezierPath.move(to: CGPoint(x: 16, y: 11))
        bezierPath.addLine(to: CGPoint(x: 25, y: 20))
        bezierPath.addLine(to: CGPoint(x: 16, y: 29))
        UIColor.darkGray.setStroke()
        bezierPath.lineWidth = 2
        bezierPath.stroke()

    }
}
