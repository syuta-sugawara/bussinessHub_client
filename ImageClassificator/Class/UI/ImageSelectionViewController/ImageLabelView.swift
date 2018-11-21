import UIKit

class ImagelabelView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    init(frame: CGRect, image: UIImage, text: String) {
        super.init(frame: frame)
        let imageView = constructImageView(image: image)
        constructLabel(text: text, imageView: imageView)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

    func constructImageView(image: UIImage) -> UIImageView {
        let topPadding: CGFloat = 10.0
        let frame = CGRect(
            x: floor((self.bounds.width - image.size.width)/2), y: topPadding,
            width: image.size.width, height: image.size.height
        )
        let imageView = UIImageView(frame: frame)
        imageView.image = image
        addSubview(imageView)
        return imageView
    }

    func constructLabel(text: String, imageView: UIImageView) {
        let height: CGFloat = 18.0
        let frame = CGRect(
            x: 0, y: imageView.frame.maxY,
            width: self.bounds.width, height: height
        )
        let label = UILabel(frame: frame)
        label.text = text
        addSubview(label)
    }
}
