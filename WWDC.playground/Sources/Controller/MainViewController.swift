import Foundation
import AVFoundation
import UIKit

extension String {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
}

//feedbackGenerator used to generate haptic feedback
var feedbackGenerator: UIImpactFeedbackGenerator? = nil
var appTitle: UILabel!
var convertText: UILabel!
var textToConvert: UITextView!
var knowMoreBtn: KnowMoreBtn!
var alertPlayer: AVAudioPlayer!
var infoLabel: UILabel!

var knowMore: KnowMoreViewController!

let btnHeight: CGFloat = 30
let btnWidth: CGFloat = 90
let btnBGColor: UIColor = UIColor(red:0.38, green:0.66, blue:0.09, alpha:1.0)

let textToConvertHeight: CGFloat = 140
var collectionFrameHeight: CGFloat = 465


var scrollDownBtn: UIButton!
var scrollUpBtn: UIButton!
var convertBtn: UIButton!

var collectionFrame: CGRect!
let cellReuseIdentifier = "reuseCell"
var collectionView1: UICollectionView!
var cellSize = CGSize(width: 0, height: 0)
var brailles = [UIView]()

public class MainViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        setupTextToConvert(self)
        setupCollectionView(self)
        setupAppTitle()
        setupScrollDownBtn()
        setupScrollUpBtn()
        setupConvertText()
        setupConvertBtn()
        setupKnowMoreBtn()
        setupAudio()
        setupInfoLabel()
        
        view.addSubview(textToConvert)
        view.addSubview(appTitle)
        view.addSubview(convertText)
        view.addSubview(collectionView1)
        view.addSubview(scrollDownBtn)
        view.addSubview(scrollUpBtn)
        view.addSubview(convertBtn)
        view.addSubview(knowMoreBtn)
        view.addSubview(infoLabel)
        
        
        scrollDownBtn.addTarget(self, action: #selector(scrollDownPressed), for: .touchUpInside)
        scrollUpBtn.addTarget(self, action: #selector(scrollUpPressed), for: .touchUpInside)
        convertBtn.addTarget(self, action: #selector(convertBtnPressed), for: .touchUpInside)
        knowMoreBtn.addTarget(self, action: #selector(knowMorePressed), for: .touchUpInside)
    }
    
    @objc func scrollDownPressed() {
        if collectionView1.numberOfItems(inSection: 0) != 0 {
            //numbers of columns in collectionView
            let cols = calcNumberOfCellsPerRow()
            //number of rows in collectionView
            let rows = calcNumberOfCellsPerColumn()
            
            let currentTopItem = collectionView1.indexPathsForVisibleItems.sorted()[0].item
            let lastItem = collectionView1.numberOfItems(inSection: 0) - 1
            if ((currentTopItem + (rows*cols)) % lastItem) == (currentTopItem + (rows*cols)) || ((currentTopItem + (rows*cols)) == lastItem) {
                collectionView1.scrollToItem(at: IndexPath(item: currentTopItem + (rows*cols), section: 0), at: .bottom, animated: true)
            } else {
                infoLabel.isHidden = false
                infoLabel.text = "Already at the bottom"
            }
        } else {}
        textToConvert.resignFirstResponder()
    }
    
    @objc func scrollUpPressed() {
        if collectionView1.numberOfItems(inSection: 0) != 0 {
            //number of rows in collectionView
            let rows = calcNumberOfCellsPerColumn()
            let currentTopItem = collectionView1.indexPathsForVisibleItems.sorted()[0].item
            if currentTopItem >= rows {
                collectionView1.scrollToItem(at: IndexPath(item: currentTopItem - rows, section: 0), at: .top, animated: true)
            } else {
                infoLabel.isHidden = false
                infoLabel.text = "Already at the top"
            }
        } else {}
        textToConvert.resignFirstResponder()
    }
    
    
    //called when convertBtn is pressed
    @objc func convertBtnPressed() {
        brailles.removeAll()
        if collectionView1.numberOfItems(inSection: 0) != 0 {
            collectionView1.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
            
        }
        collectionView1.reloadData()
        textToConvert.resignFirstResponder()
    }
    
    //called when knowmoreBtn is pressed
    @objc func knowMorePressed() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        knowMore = KnowMoreViewController(collectionViewLayout: layout)
        navigationController?.pushViewController(knowMore, animated: true)
    }
    
    
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return textToConvert.text.lowercased().replacingOccurrences(of: " ", with: "").count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! BrailleCell
        let charFromString = textToConvert.text.lowercased().replacingOccurrences(of: " ", with: "")[indexPath.item]
        //configures the cell with the colorAray from getArrayFromChar func
        cell.configureCell(colorArry: getArrayFromChar(charFromString))
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //sets cell size so that the brailles remains perfect circles
        cellSize = calcCellViewSizeFromBraille(width: 26, height: 26)
        return cellSize
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    
    public func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? BrailleCell else { return }
        //removes the dark brailles of the cells that are no longer on the screen
        brailles = Array(Set(brailles).subtracting(cell.brailles))
    }
    
    public func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let cell = cell as? BrailleCell else { return }
        //adds newly displayed cells' dark braille to the array (brailles array)
        addDarkBraille(cell, indexpath: indexPath)
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        testTouches(touches: touches, fromTouchesMoved: false)
    }
    
    
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        testTouches(touches: touches, fromTouchesMoved: true)
    }
    
    //Called when the user touches the screen, if the touch location contains a darkBraille it calls feedbackReceived() fun
    //further if the touch started and ended on the same braille, feedbackReceived() is NOT called, thus avoiding repeated function calls.
    func testTouches(touches: Set<UITouch>, fromTouchesMoved: Bool) {
        feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        let touch = touches.first!
        let prevTouch = touch.previousLocation(in: view)
        let touchLocation = touch.location(in: view)
        for braille in brailles {
            let brailleViewFrame = braille.superview!.convert(braille.frame, to: self.view)
            if fromTouchesMoved && brailleViewFrame.contains(prevTouch) {}
            else {
                if brailleViewFrame.contains(touchLocation) {
                    feedbackGenerator?.impactOccurred()
                    feedbackReceived()
                    feedbackGenerator = nil
                }
            }
        }
    }
}

//sets up appTitle label
func setupAppTitle() {
    appTitle = UILabel()
    appTitle.frame = CGRect(x: 0, y: 0, width: collectionFrame.width, height: 60)
    appTitle.text = "Braille Reader"
    appTitle.textAlignment = .center
    appTitle.textColor = UIColor.white
    appTitle.font = UIFont(name: "helvetica neue", size: 26)
    appTitle.backgroundColor = btnBGColor
}

//sets up convertText Label
func setupConvertText() {
    convertText = UILabel()
    convertText.frame = CGRect(x: 4, y: 100, width: 220, height: 24)
    convertText.text = "Convert English to Braille script: "
    convertText.textAlignment = .left
    convertText.textColor = UIColor.darkGray
    convertText.font = UIFont(name: "helvetica neue", size: 14)
}

//sets up textToConvert text view
func setupTextToConvert(_ vc: MainViewController) {
    textToConvert = UITextView()
    textToConvert.frame = CGRect(x: 0, y: 135, width: vc.view.frame.width, height: collectionFrameHeight - 150)
    textToConvert.layer.borderWidth = 0.3
    textToConvert.layer.borderColor = UIColor.lightGray.cgColor
}

//sets up collectionView1
func setupCollectionView(_ vc: MainViewController) {
    collectionFrame = CGRect(x: 0, y: (vc.view.frame.height - collectionFrameHeight), width: vc.view.frame.width, height: collectionFrameHeight)
    
    
    collectionView1 = UICollectionView(frame: collectionFrame, collectionViewLayout: UICollectionViewFlowLayout())
    collectionView1.register(BrailleCell.self, forCellWithReuseIdentifier: cellReuseIdentifier)
    
    collectionView1.delegate = vc
    collectionView1.dataSource = vc
    
    collectionView1.backgroundColor = .white
    collectionView1.layer.borderWidth = 0.3
    collectionView1.layer.borderColor = UIColor.lightGray.cgColor
    collectionView1.isScrollEnabled = false
    collectionView1.isUserInteractionEnabled = false
    
}

//sets up convertBtn
func setupConvertBtn() {
    convertBtn = UIButton(type: .roundedRect)
    convertBtn.setTitle("Convert", for: .normal)
    convertBtn.setTitleColor(.white, for: .normal)
    convertBtn.frame = CGRect(x: (collectionFrame.midX - (btnWidth/2)), y: textToConvert.frame.height + 150, width: btnWidth, height: btnHeight)
    convertBtn.backgroundColor = btnBGColor
}

//sets up scrollDownBtn
func setupScrollDownBtn() {
    scrollDownBtn = UIButton(type: .roundedRect)
    scrollDownBtn.setTitle("Scroll Down", for: .normal)
    scrollDownBtn.setTitleColor(.white, for: .normal)
    scrollDownBtn.frame = CGRect(x: (collectionFrame.maxX - 95), y: (collectionFrame.minY - 50), width: btnWidth, height: btnHeight)
    scrollDownBtn.backgroundColor = btnBGColor
}

//sets up scrollUpBn
func setupScrollUpBtn() {
    scrollUpBtn = UIButton(type: .roundedRect)
    scrollUpBtn.setTitle("Scroll Up", for: .normal)
    scrollUpBtn.setTitleColor(.white, for: .normal)
    scrollUpBtn.frame = CGRect(x: (collectionFrame.minX + 15), y: (collectionFrame.minY - 50), width: btnWidth, height: btnHeight)
    scrollUpBtn.backgroundColor = btnBGColor
}

//sets up knowMoreBtn
func setupKnowMoreBtn() {
    knowMoreBtn = KnowMoreBtn()
    let frame = CGRect(x: (collectionFrame.width - 45), y: 15, width: 31, height: 31)
    knowMoreBtn.frame = frame
    knowMoreBtn.backgroundColor = UIColor.clear
}

//sets up alertPlayer and prepares to play
func setupAudio() {
    let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "alert", ofType: "mp3")!)
    do {
        alertPlayer = try AVAudioPlayer(contentsOf: alertSound)
        alertPlayer.prepareToPlay()
    } catch {
        print("Error loading alert sound")
    }
    
}

//sets up infoLabel
func setupInfoLabel() {
    infoLabel = UILabel()
    let infoLabelFrame = CGRect(x: (collectionFrame.width - 400)/2, y: collectionFrame.minY - 50, width: 400, height: btnHeight)
    infoLabel.frame = infoLabelFrame
    infoLabel.textColor = .darkGray
    infoLabel.textAlignment = .center
    infoLabel.isHidden = true
}


//adds dark Braille (raised cell) to the brailles array
func addDarkBraille(_ cell: BrailleCell, indexpath: IndexPath) {
    for i in 0..<6 {
        if cell.brailles[i].isDark {
            brailles.append(cell.brailles[i])
        }
    }
}

//Called when user touches a dark braille (raised circle). plays alert sound and updates infoLabel
func feedbackReceived() {
    print("Touched Dark Braille!")
    alertPlayer.currentTime = 0.0
    alertPlayer.play()
    infoLabel.isHidden = false
    infoLabel.text = "Touched Dark Braille!"
    
}

//calculates cell size from the braille width and height
func calcCellViewSizeFromBraille(width: CGFloat, height: CGFloat) -> CGSize {
    let cellViewWidth = (2 * width) + 5
    let cellViewHeight = 3 * (height + 5)
    return CGSize(width: cellViewWidth, height: cellViewHeight)
}

//calculates number of cells per column
func calcNumberOfCellsPerRow() -> Int {
    let widthPerCell = cellSize.width
    return Int((collectionView1.frame.width/(widthPerCell + 25)) + 1)
}

//calculates number of cells per column
func calcNumberOfCellsPerColumn() -> Int {
    let heightPerCell = cellSize.height
    return Int((collectionView1.frame.height/heightPerCell))
}

//Hardcoded colorArray for all english characters
func getArrayFromChar(_ char: Character) -> [Int] {
    switch char {
    case "a":
        return [1,0,0,0,0,0]
    case "b":
        return [1,0,1,0,0,0]
    case "c":
        return [1,1,0,0,0,0]
    case "d":
        return [1,1,0,1,0,0]
    case "e":
        return [1,0,0,1,0,0]
    case "f":
        return [1,1,1,0,0,0]
    case "g":
        return [1,1,1,1,0,0]
    case "h":
        return [1,0,1,1,0,0]
    case "i":
        return [0,1,1,0,0,0]
    case "j":
        return [0,1,1,1,0,0]
    case "k":
        return [1,0,0,0,1,0]
    case "l":
        return [1,0,1,0,1,0]
    case "m":
        return [1,1,0,0,1,0]
    case "n":
        return [1,1,0,1,1,0]
    case "o":
        return [1,0,0,1,1,0]
    case "p":
        return [1,1,1,0,1,0]
    case "q":
        return [1,1,1,1,1,0]
    case "r":
        return [1,0,1,1,1,0]
    case "s":
        return [0,1,1,0,1,0]
    case "t":
        return [0,1,1,1,1,0]
    case "u":
        return [1,0,0,0,1,1]
    case "v":
        return [1,0,1,0,1,1]
    case "w":
        return [0,1,1,1,0,1]
    case "x":
        return [1,1,0,0,1,1]
    case "y":
        return [1,1,0,1,1,1]
    case "z":
        return [1,0,0,1,1,1]
    case "0":
        return [0,1,1,1,0,0]
    case "1":
        return [1,0,0,0,0,0]
    case "2":
        return [1,0,1,0,0,0]
    case "3":
        return [1,1,0,0,0,0]
    case "4":
        return [1,1,0,1,0,0]
    case "5":
        return [1,0,0,1,0,0]
    case "6":
        return [1,1,1,0,0,0]
    case "7":
        return [1,1,1,1,0,0]
    case "8":
        return [1,0,1,1,0,0]
    case "9":
        return [0,1,1,0,0,0]
    default:
        return [0,0,0,0]
    }
    
}



