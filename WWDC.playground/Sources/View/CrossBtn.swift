import Foundation
import UIKit

class CrossBtn: UIButton {
    override func draw(_ rect: CGRect) {
        //Draws a 30x30 Circle
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 1, y: 1, width: 30, height: 30))
        UIColor.gray.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        
        //Draws the cross "X" inside the circle
        let crossPath = UIBezierPath()
        crossPath.move(to: CGPoint(x: 9.5, y: 9.5))
        crossPath.addCurve(to: CGPoint(x: 17.18, y: 17.18), controlPoint1: CGPoint(x: 12.96, y: 12.96), controlPoint2: CGPoint(x: 15.42, y: 15.42))
        crossPath.addCurve(to: CGPoint(x: 21.5, y: 21.5), controlPoint1: CGPoint(x: 21.28, y: 21.28), controlPoint2: CGPoint(x: 21.5, y: 21.5))
        crossPath.move(to: CGPoint(x: 9.5, y: 21.5))
        crossPath.addCurve(to: CGPoint(x: 17.18, y: 13.82), controlPoint1: CGPoint(x: 12.96, y: 18.04), controlPoint2: CGPoint(x: 15.42, y: 15.58))
        crossPath.addCurve(to: CGPoint(x: 21.5, y: 9.5), controlPoint1: CGPoint(x: 21.28, y: 9.72), controlPoint2: CGPoint(x: 21.5, y: 9.5))
        UIColor.gray.setStroke()
        crossPath.lineWidth = 1
        crossPath.stroke()

    }
}
