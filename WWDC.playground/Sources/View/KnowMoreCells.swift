import Foundation
import UIKit



class KnowMoreCells: UICollectionViewCell {
    var titleLabel: UILabel!
    var messageLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureViews() {
        //initialises btn ans labels
        crossBtn = CrossBtn()
        titleLabel = UILabel()
        messageLabel = UILabel()
        
        //sets up titleLabel with text color as dark gray
        let titleFrame = CGRect(x: 15, y: 95, width: (frame.width - 30), height: 80)
        titleLabel.frame = titleFrame
        titleLabel.font = UIFont(name: "helvetica neue", size: 36)
        titleLabel.textAlignment = .center
        titleLabel.textColor = .darkGray
        
        
        //sets up messageLabel with text color as dark gray
        let messageFrame = CGRect(x: 15, y: 190, width: (frame.width - 30), height: 250)
        messageLabel.frame = messageFrame
        messageLabel.font = UIFont(name: "helvetica neue", size: 20)
        messageLabel.numberOfLines = 10
        messageLabel.lineBreakMode = .byWordWrapping
        messageLabel.textAlignment = .center
        messageLabel.textColor = .darkGray
        
        
        
        //adds to sub view
        addSubview(titleLabel)
        addSubview(messageLabel)
    }
    
    //sets the text of title and message label as the text received
    func configureCell(_ title: String, _ message: String) {
        titleLabel.text = title
        messageLabel.text = message
    }
}
