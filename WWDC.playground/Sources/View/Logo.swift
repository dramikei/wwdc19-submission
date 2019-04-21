import Foundation
import UIKit

class Logo: UIView {
    override func draw(_ rect: CGRect) {
        //Sets context as current context
        let context = UIGraphicsGetCurrentContext()!
        
        
        //Draws the arc
        let ovalRect = CGRect(x: 1, y: 1, width: 125, height: 125)
        let ovalPath = UIBezierPath()
        ovalPath.addArc(withCenter: CGPoint(x: ovalRect.midX, y: ovalRect.midY), radius: ovalRect.width / 2, startAngle: 255 * CGFloat.pi/180, endAngle: 206 * CGFloat.pi/180, clockwise: true)
        
        UIColor.gray.setStroke()
        ovalPath.lineWidth = 3
        ovalPath.stroke()
        
        
        //Draws the "B" inside the arc and transforms it
        context.saveGState()
        context.translateBy(x: 11.82, y: 20.77)
        context.rotate(by: -15 * CGFloat.pi/180)
        
        let textRect = CGRect(x: 0, y: 0, width: 79.09, height: 102.01)
        let textTextContent = "B"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [
            .font: UIFont(name: "AvenirNext-UltraLight", size: 121)!,
            .foregroundColor: UIColor.darkGray,
            .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()
        

    }
}
