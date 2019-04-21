import Foundation
import UIKit

//Braille Reader Logo
var logo: Logo!
//"Braille Reader" label
var brailleText: UILabel!
//"WWDC19" label
var wwdcText: UILabel!
//"By" label
var byText: UILabel!
//"Raghav Vashisht" label
var raghavText: UILabel!
//Next Button
var nextBtn: NextButton!
//Spinner
var spinner: UIActivityIndicatorView!

let textHeight: CGFloat = 20
let textFont: UIFont = UIFont(name: "helvetica neue", size: 16)!
let nextBtnWidth: CGFloat = 42
let nextBtnHeight: CGFloat = 42

public class StartViewController: UIViewController {
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews(self)
        view.addSubview(logo)
        view.addSubview(brailleText)
        view.addSubview(wwdcText)
        view.addSubview(byText)
        view.addSubview(raghavText)
        view.addSubview(nextBtn)
        view.addSubview(spinner)
        
        //Sets the function to execute as gotoMainVC func when nextBtn is pressed
        nextBtn.addTarget(self, action: #selector(gotoMainVC), for: .touchUpInside)
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //Starts the animation when the view appears on screen
        startAnimations()
    }
    
    @objc func gotoMainVC() {
        //unhides and starts the spinning animation of spinner
        spinner.isHidden = false
        spinner.startAnimating()
        //Initialises mainVC as MainViewController
        let mainVC = MainViewController()
        //Pushes mainVC onto the navigationController
        navigationController?.pushViewController(mainVC, animated: true)
    }
    
    
}
func setupViews(_ vc: UIViewController) {
    //Sets up Logo with a clear background
    logo = Logo()
    let logoFrame = CGRect(x: (vc.view.frame.width - 125)/2, y: 220, width: 130, height: 130)
    logo.frame = logoFrame
    logo.backgroundColor = .clear
    logo.alpha = 0
    
    //sets up brailleText with text color dark Gray and font Helvetica Neue
    brailleText = UILabel()
    let brailleTextFrame = CGRect(x: 0, y: logoFrame.maxY + 12, width: vc.view.frame.width, height: textHeight)
    brailleText.frame = brailleTextFrame
    brailleText.text = "Braille Reader"
    brailleText.textAlignment = .center
    brailleText.font = UIFont(name: "helvetica neue", size: 18)
    brailleText.textColor = .darkGray
    brailleText.alpha = 0
    
    //sets up wwdcText with text color dark gray and font Helvetica Neue
    wwdcText = UILabel()
    let wwdcTextFrame = CGRect(x: 0, y: brailleTextFrame.maxY + 5, width: vc.view.frame.width, height: textHeight)
    wwdcText.frame = wwdcTextFrame
    wwdcText.text = "WWDC19 Submission"
    wwdcText.textAlignment = .center
    wwdcText.font = textFont
    wwdcText.textColor = .darkGray
    wwdcText.alpha = 0
    
    //sets up byText with text color dark gray and font Helvetica Neue
    byText = UILabel()
    let byTextFrame = CGRect(x: 0, y: wwdcTextFrame.maxY + 5, width: vc.view.frame.width, height: textHeight)
    byText.frame = byTextFrame
    byText.text = "by"
    byText.textAlignment = .center
    byText.font = textFont
    byText.textColor = .darkGray
    byText.alpha = 0
    
    //sets up raghavText with text color dark gray and font Helvetica Neue
    raghavText = UILabel()
    let raghavTextFrame = CGRect(x: 0, y: byTextFrame.maxY + 5, width: vc.view.frame.width, height: textHeight)
    raghavText.frame = raghavTextFrame
    raghavText.text = "Raghav Vashisht"
    raghavText.textAlignment = .center
    raghavText.font = textFont
    raghavText.textColor = .darkGray
    raghavText.alpha = 0
    
    //sets up nextBtn with custom class and clear background color
    nextBtn = NextButton()
    let btnX : CGFloat = (vc.view.frame.width - nextBtnWidth)/2
    let nxtBtnFrame = CGRect(x: btnX, y: raghavTextFrame.maxY + 12, width: nextBtnWidth, height: nextBtnHeight)
    nextBtn.frame = nxtBtnFrame
    nextBtn.backgroundColor = .clear
    nextBtn.alpha = 0
    
    //sets up spinner and makes it hidden
    spinner = UIActivityIndicatorView(style: .gray)
    let spinnerX: CGFloat = (vc.view.frame.width - 20)/2
    let spinnerFrame = CGRect(x: spinnerX, y: nxtBtnFrame.maxY + 10, width: 20, height: 20)
    spinner.frame = spinnerFrame
    spinner.isHidden = true
}

//Chained Animations for the UI elements

func startAnimations() {
    UIView.animate(withDuration: 1.3, animations: {
        logo.alpha = 1
    }) { (true) in
        UIView.animate(withDuration: 0.8, animations: {
            brailleText.alpha = 1
        }, completion: { (true) in
            UIView.animate(withDuration: 0.8, animations: {
                wwdcText.alpha = 1
            }, completion: { (true) in
                UIView.animate(withDuration: 0.8, animations: {
                    byText.alpha = 1
                }, completion: { (true) in
                    UIView.animate(withDuration: 0.8, animations: {
                        raghavText.alpha = 1
                    }, completion: { (true) in
                        UIView.animate(withDuration: 0.8, animations: {
                            nextBtn.alpha = 1
                        })
                    })
                })
            })
        })
    }
}


