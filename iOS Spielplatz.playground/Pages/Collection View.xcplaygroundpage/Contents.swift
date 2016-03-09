//: [Previous](@previous)
import UIKit
import XCPlayground

class DataSource: NSObject, UICollectionViewDataSource {
  var data: [Int] = []
  
  override init() {
    for i in 0..<19 {
      data.append(i)
    }
    super.init()
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath)
    cell.backgroundColor = UIColor.randomColor()
    return cell
  }
}

func delayOnMainQueue(delay:Double, closure: (() -> Void)) {
  dispatch_after(
    dispatch_time(DISPATCH_TIME_NOW,Int64(delay * Double(NSEC_PER_SEC))
    ), dispatch_get_main_queue(), closure)
}

let flowLayout = UICollectionViewFlowLayout()
flowLayout.itemSize = CGSize(width: 80, height: 80)
flowLayout.minimumLineSpacing = 25
let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: flowLayout)
collectionView.frame = CGRectMake(0, 0, 400, 600)

collectionView.backgroundColor = UIColor.lightGrayColor()

XCPlaygroundPage.currentPage.liveView = collectionView

collectionView.registerClass(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
let dataSource = DataSource()
collectionView.dataSource = dataSource

for i in 1...9 {
 delayOnMainQueue( Double(i * 2)) {
    dataSource.data.removeFirst()
    dataSource.data.append(9 + i)
    
    collectionView.performBatchUpdates({
      collectionView.deleteItemsAtIndexPaths([NSIndexPath(forItem: i - 1, inSection: 0)])
      collectionView.insertItemsAtIndexPaths([NSIndexPath(forItem: 18, inSection: 0)])
      }, completion: { completed in
    })
  }
}

//: [Next](@next)
