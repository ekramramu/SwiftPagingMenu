import UIKit
import Parchment

protocol ImagesViewControllerDelegate: class {
  func imagesViewControllerDidScroll(_: ImagesViewController)
}

class ImagesViewController: UIViewController {
  
  weak var delegate: ImagesViewControllerDelegate?
  
  fileprivate let images: [UIImage]
  
  fileprivate lazy var collectionViewLayout: UICollectionViewFlowLayout = {
    let layout = UICollectionViewFlowLayout()
    return layout
  }()
  
  lazy var collectionView: UICollectionView = {
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.collectionViewLayout)
    collectionView.backgroundColor = .white
   
    return collectionView
  }()
    
    //Initilize TopVC
  
  init(images: [UIImage], options: PagingOptions) {
    self.images = images
    super.init(nibName: nil, bundle: nil)
    view.addSubview(collectionView)
    view.constrainToEdges(collectionView)
    
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(
      ImageCollectionViewCell.self,
      forCellWithReuseIdentifier: ImageCollectionViewCell.reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    collectionViewLayout.invalidateLayout()
  }
  
}

extension ImagesViewController: UICollectionViewDelegateFlowLayout {

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
        
        if  indexPath.row != 0 && (indexPath.row % 6) == 0 {
            print("index ; \(indexPath.row)")
            return CGSize(width: ((width - 12)) - 12, height: CGFloat(collectionView.bounds.height/2) + 14)
        } else{
            return CGSize(width: ((width - 12) / 2) - 12, height: CGFloat(collectionView.bounds.height/2) + 14)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 12, left: 12, bottom: 0, right:12)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    delegate?.imagesViewControllerDidScroll(self)
  }
  
}

extension ImagesViewController: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionViewCell.reuseIdentifier, for: indexPath) as! ImageCollectionViewCell
    cell.setImage(images[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "DetailVC") as! DetailVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
  
}
