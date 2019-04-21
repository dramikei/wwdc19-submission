import Foundation
import UIKit

var knowMoreData = KnowMoreData()
var pageControl = UIPageControl()
var crossBtn: CrossBtn!


class KnowMoreViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePageControl()
        collectionView.backgroundColor = .white
        //Registers custom cell class with the collectionView
        collectionView.register(KnowMoreCells.self, forCellWithReuseIdentifier: "cellID")
        collectionView.isPagingEnabled = true
        //configures the cross (back) button
        configureCrossBtn()
        view.addSubview(crossBtn)
        view.addSubview(pageControl)
        //calls crossPressed func when crossBtn is pressed
        crossBtn.addTarget(self, action: #selector(crossPressed), for: .touchUpInside)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return knowMoreData.titles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as! KnowMoreCells
        let title = knowMoreData.titles[indexPath.item]
        let message = knowMoreData.messages[indexPath.item]
        //configures cell with title and message
        cell.configureCell(title, message)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //sets the current page of pageControl according to the cell displayed
        pageControl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //sets the cell size ro fill the entire screen
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //Configues crossBtn
    func configureCrossBtn() {
        crossBtn = CrossBtn()
        let crossBtnFrame = CGRect(x: 15, y: 15, width: 32, height: 32)
        crossBtn.frame = crossBtnFrame
    }
    
    //Configues pageControl
    func configurePageControl() {
        pageControl.numberOfPages = knowMoreData.titles.count
        let pageControlFrame = CGRect(x: (view.frame.width - 30)/2, y: view.frame.height - 45, width: 30, height: 15)
        pageControl.frame = pageControlFrame
        pageControl.currentPageIndicatorTintColor = .green
        pageControl.pageIndicatorTintColor = .lightGray
    }
    
    @objc func crossPressed() {
        //Removes the current view controller and goes back to mainViewController
        navigationController?.popViewController(animated: true)
    }
    
}
