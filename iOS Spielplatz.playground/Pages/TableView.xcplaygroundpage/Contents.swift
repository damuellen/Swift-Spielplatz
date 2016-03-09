//: [Previous](@previous)
import XCPlayground
import UIKit

class TableViewCell: UITableViewCell {
  
  static let identifier: String = "Cell"
  
  var leftLabel: UILabel!
  var rightLabel: UILabel!
  
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    self.backgroundColor = UIColor.whiteColor()
    
    leftLabel = prepareLabel(UILabel())
    leftLabel.textAlignment = .Left
    contentView.addSubview(leftLabel)
    
    rightLabel = prepareLabel(UILabel())
    rightLabel.textAlignment = .Right
    contentView.addSubview(rightLabel)
    
    let views = ["leftLabel": leftLabel, "rightLabel": rightLabel]
    var layoutConstraints = [NSLayoutConstraint]()
    
    layoutConstraints += NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-[leftLabel]-|",
                                   options: [NSLayoutFormatOptions.AlignAllLeft],
                                   metrics: nil, views: views)
    layoutConstraints += NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[leftLabel]|", options: [],
                                   metrics: nil, views: views)
    layoutConstraints += NSLayoutConstraint
      .constraintsWithVisualFormat("H:|-[rightLabel]-|",
                                   options: [NSLayoutFormatOptions.AlignAllRight],
                                   metrics: nil, views: views)
    layoutConstraints += NSLayoutConstraint
      .constraintsWithVisualFormat("V:|[rightLabel]|", options: [],
                                   metrics: nil, views: views)
    
    NSLayoutConstraint.activateConstraints(layoutConstraints)
    
  }
  
  let prepareLabel: UILabel -> UILabel = { label in
    label.frame = CGRectZero
    label.textColor = UIColor.darkGrayColor()
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class TableProvider: NSObject, UITableViewDelegate, UITableViewDataSource {
  
  weak var tableView: UITableView?
  
  static let possibleNames = [
    "Princess Luna",
    "Rainbow Dash",
    "Bubbles",
    "Rarity",
    "Applejack",
    "Firefly",
    "Pinkie Pie",
    "Fluttershy",
    "Discord",
    "Twilight Sparkle"
  ]
  
  var names: [String] = possibleNames {

    didSet {
      let oldRows = oldValue
      let newRows = self.names
      let diff = oldRows.diff(newRows)
      if (diff.results.count > 0) {
        tableView?.beginUpdates()
        
        let insertionIndexPaths = diff.insertions.map({ NSIndexPath(forRow: $0.idx, inSection: 0) })
        let deletionIndexPaths = diff.deletions.map({ NSIndexPath(forRow: $0.idx, inSection: 0) })
        
        tableView?.insertRowsAtIndexPaths(insertionIndexPaths, withRowAnimation: .Fade)
        tableView?.deleteRowsAtIndexPaths(deletionIndexPaths, withRowAnimation: .Automatic)
      //  tableView?.reloadData()
        tableView?.endUpdates()
      }
    }
  }
  
  func registerCellsForTableview(tableView: UITableView) {
    tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: "Cell")
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return names.count
  }
  
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    
    let cell = tableView.dequeueReusableCellWithIdentifier(TableViewCell.identifier, forIndexPath: indexPath) as! TableViewCell
    
    cell.leftLabel.text = "Entry \(indexPath.row+1)"
    cell.rightLabel.text = names[indexPath.row]
    
    return cell
  }
  
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    print("You selected cell #\(indexPath.row)!")
  }
  
}

class TableViewController: UITableViewController {

  var datasource: TableProvider?

  @objc func shuffle() {
    datasource!.names = randomized(TableProvider.possibleNames)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.registerClass(TableViewCell.self, forCellReuseIdentifier: TableViewCell.identifier)
    
    tableView.dataSource = datasource
    tableView.delegate = datasource
    
    datasource?.tableView = tableView
    
    tableView.rowHeight = UITableViewAutomaticDimension
    
    let shuffleButton = UIBarButtonItem(title: "Shuffle",
                                        style: .Plain,
                                        target: self,
                                        action: #selector(TableViewController.shuffle))
    
    self.navigationItem.rightBarButtonItem = shuffleButton
  }

}

let nc = UINavigationController()
let vc = TableViewController()
nc.viewControllers = [vc]
vc.datasource = TableProvider()
XCPlaygroundPage.currentPage.liveView = nc


//: [Next](@next)
