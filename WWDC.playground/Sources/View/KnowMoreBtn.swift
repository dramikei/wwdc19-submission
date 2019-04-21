import Foundation
import UIKit


class KnowMoreBtn: UIButton {
    override func draw(_ rect: CGRect) {
        //Sets context as current context
        let context = UIGraphicsGetCurrentContext()!
        
        // Color Declarations
        let color = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 0.0)
        
        
        //Draws a 29x29 Circle
        let ovalPath = UIBezierPath(ovalIn: CGRect(x: 0.5, y: 0.5, width: 29, height: 29))
        color.setFill()
        ovalPath.fill()
        UIColor.white.setStroke()
        ovalPath.lineWidth = 1
        ovalPath.stroke()
        
        
        //Draws QuestionMark "?"
        let textRect = CGRect(x: 8, y: 6, width: 13, height: 19)
        let textTextContent = "?"
        let textStyle = NSMutableParagraphStyle()
        textStyle.alignment = .center
        let textFontAttributes = [
            .font: UIFont(name: "HelveticaNeue", size: 24)!,
            .foregroundColor: UIColor.white,
            .paragraphStyle: textStyle,
            ] as [NSAttributedString.Key: Any]
        
        let textTextHeight: CGFloat = textTextContent.boundingRect(with: CGSize(width: textRect.width, height: CGFloat.infinity), options: .usesLineFragmentOrigin, attributes: textFontAttributes, context: nil).height
        context.saveGState()
        context.clip(to: textRect)
        textTextContent.draw(in: CGRect(x: textRect.minX, y: textRect.minY + (textRect.height - textTextHeight) / 2, width: textRect.width, height: textTextHeight), withAttributes: textFontAttributes)
        context.restoreGState()

    }
}
