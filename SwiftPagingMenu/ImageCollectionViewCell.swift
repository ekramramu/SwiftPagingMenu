import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
  
  static let reuseIdentifier: String = "ImageCellIdentifier"
  
  fileprivate lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    return imageView
  }()
    fileprivate var gradientImageView:UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .red
        return imageView
    }()
    
    let myView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12
        view.backgroundColor = .brown
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.clipsToBounds = true
    contentView.addSubview(myView)
    myView.addSubview(imageView)
    myView.constrainToEdgesForView(imageView)
    contentView.constrainToEdges(myView)
   
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setImage(_ image: UIImage) {
   imageView.image = image
    imageView.layer.cornerRadius = 12
    imageView.clipsToBounds = true
  }
  
}
