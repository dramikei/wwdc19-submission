import Foundation
import UIKit

class BrailleCell: UICollectionViewCell {
    var topLeft = Braille()
    var topRight = Braille()
    var midLeft = Braille()
    var midRight = Braille()
    var bottomLeft = Braille()
    var bottomRight = Braille()
    var brailles = [Braille]()
    let horizontalStackView1 = UIStackView()
    let horizontalStackView2 = UIStackView()
    let horizontalStackView3 = UIStackView()
    let verticalStackView = UIStackView()
    
    let brailleWidth = 10
    let brailleHeight = 10
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //setsup Stackviews which store Brailles in a row
        horizontalStackView1.axis = .horizontal
        horizontalStackView1.alignment = .fill
        horizontalStackView1.distribution = .fillEqually
        horizontalStackView1.spacing = 5
        horizontalStackView1.isUserInteractionEnabled = false
        
        addSubview(horizontalStackView1)
        horizontalStackView1.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView1.addArrangedSubview(topLeft)
        horizontalStackView1.addArrangedSubview(topRight)
        
        horizontalStackView2.axis = .horizontal
        horizontalStackView2.alignment = .fill
        horizontalStackView2.distribution = .fillEqually
        horizontalStackView2.spacing = 5
        horizontalStackView2.isUserInteractionEnabled = false
        
        addSubview(horizontalStackView2)
        horizontalStackView2.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView2.addArrangedSubview(midLeft)
        horizontalStackView2.addArrangedSubview(midRight)
        
        
        horizontalStackView3.axis = .horizontal
        horizontalStackView3.alignment = .fill
        horizontalStackView3.distribution = .fillEqually
        horizontalStackView3.spacing = 5
        horizontalStackView3.isUserInteractionEnabled = false
        
        addSubview(horizontalStackView3)
        horizontalStackView3.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView3.addArrangedSubview(bottomLeft)
        horizontalStackView3.addArrangedSubview(bottomRight)
        
        
        //Stackview stores other 3 stackviews in a vertical arrangement
        verticalStackView.axis = .vertical
        verticalStackView.alignment = .fill
        verticalStackView.distribution = .fillEqually
        verticalStackView.spacing = 5
        verticalStackView.isUserInteractionEnabled = false
        
        addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        verticalStackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        verticalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        verticalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        verticalStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        verticalStackView.addArrangedSubview(horizontalStackView1)
        verticalStackView.addArrangedSubview(horizontalStackView2)
        verticalStackView.addArrangedSubview(horizontalStackView3)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(colorArry: [Int]) {
        //Sets the color property of braille according to the colorArray received
        
        if colorArry[0] == 0 {
            topLeft.backgroundColor = .white
        } else {
            topLeft.backgroundColor = .darkGray
            topLeft.isDark = true
        }
        
        if colorArry[1] == 0 {
            topRight.backgroundColor = .white
        } else {
            topRight.backgroundColor = .darkGray
            topRight.isDark = true
        }
        
        if colorArry[2] == 0 {
            midLeft.backgroundColor = .white
        } else {
            midLeft.backgroundColor = .darkGray
            midLeft.isDark = true
        }
        
        if colorArry[3] == 0 {
            midRight.backgroundColor = .white
        } else {
            midRight.backgroundColor = .darkGray
            midRight.isDark = true
        }
        
        if colorArry[4] == 0 {
            bottomLeft.backgroundColor = .white
        } else {
            bottomLeft.backgroundColor = .darkGray
            bottomLeft.isDark = true
        }
        
        if colorArry[5] == 0 {
            bottomRight.backgroundColor = .white
        } else {
            bottomRight.backgroundColor = .darkGray
            bottomRight.isDark = true
        }
        brailles = [topLeft, topRight, midLeft, midRight, bottomLeft, bottomRight]
        
    }
}
