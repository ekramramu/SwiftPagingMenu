import UIKit
import Parchment

struct ImageItem: PagingItem, Hashable, Comparable {
  let index: Int
  let title: String
  let headerImage: UIImage
  let images: [UIImage]
  
  var hashValue: Int {
    return index.hashValue &+ title.hashValue
  }
  
  static func ==(lhs: ImageItem, rhs: ImageItem) -> Bool {
    return lhs.index == rhs.index && lhs.title == rhs.title
  }
  
  static func <(lhs: ImageItem, rhs: ImageItem) -> Bool {
    return lhs.index < rhs.index
  }
}

class ViewController: UIViewController {
  
  // Let's start by creating an array of citites that we
  // will use to generate some view controllers.
  fileprivate let cities = [
    "Oslo",
    "Stockholm",
    "Tokyo",
    "Barcelona",
    "Vancouver",
    "Berlin",
    "Shanghai",
    "London",
    "Paris",
    "Chicago",
    "Madrid",
    "Munich",
    "Toronto",
    "Sydney",
    "Melbourne"
  ]
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let pagingViewController = PagingViewController<PagingIndexItem>()
    pagingViewController.dataSource = self
    pagingViewController.delegate = self
    
    // Add the paging view controller as a child view controller and
    // contrain it to all edges.
    addChild(pagingViewController)
    pagingViewController.view.frame = self.view.frame
    view.addSubview(pagingViewController.view)
    //view.constrainToEdges(pagingViewController.view)
    pagingViewController.didMove(toParent: self)
  }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
  
}

extension ViewController: PagingViewControllerDataSource {
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, pagingItemForIndex index: Int) -> T {
    return PagingIndexItem(index: index, title: DummyData.items[index].title) as! T
  }
  
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, viewControllerForIndex index: Int) -> UIViewController {
    let viewController = ImagesViewController(
        images: DummyData.items[index].images,
      options: pagingViewController.options
    )
    
    // Set the `ImagesViewControllerDelegate` that allows us to get
    // notified when the images view controller scrolls.
    
    
    // Inset the collection view with the height of the menu.
   
    return viewController
  }
  
  func numberOfViewControllers<T>(in: PagingViewController<T>) -> Int {
    return DummyData.items.count
  }
  
}

extension ViewController: PagingViewControllerDelegate {
  
  // We want the size of our paging items to equal the width of the
  // city title. Parchment does not support self-sizing cells at
  // the moment, so we have to handle the calculation ourself. We
  // can access the title string by casting the paging item to a
  // PagingTitleItem, which is the PagingItem type used by
  // FixedPagingViewController.
  func pagingViewController<T>(_ pagingViewController: PagingViewController<T>, widthForPagingItem pagingItem: T, isSelected: Bool) -> CGFloat? {
    guard let item = pagingItem as? PagingIndexItem else { return 0 }

    let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    let size = CGSize(width: CGFloat.greatestFiniteMagnitude, height: pagingViewController.menuItemSize.height)
    let attributes = [NSAttributedString.Key.font: pagingViewController.font]
    
    let rect = item.title.boundingRect(with: size,
      options: .usesLineFragmentOrigin,
      attributes: attributes,
      context: nil)

    let width = ceil(rect.width) + insets.left + insets.right
    
    if isSelected {
      return width * 1.5
    } else {
      return width
    }
  }
  
}
