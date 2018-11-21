import UIKit
import MDCSwipeToChoose
import AlamofireImage

private let choosePersonViewImageLabelWidth: CGFloat = 42.0

class ImageSelectionView: MDCSwipeToChooseView {
    typealias DataType = ImageResponse
    let data: DataType!    
    private var informationView: UIView!
    private var nameLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        self.data = nil
        super.init(coder: aDecoder)
    }

    init(frame: CGRect, data: DataType, options: MDCSwipeToChooseViewOptions) {
        self.data = data
        super.init(frame: frame, options: options)

        self.backgroundColor = .white
        self.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.imageView.autoresizingMask = self.autoresizingMask
        self.imageView.contentMode = .scaleAspectFit

        if let url = URL(string: data.imageUrl) {
            self.imageView.af_setImage(withURL: url)
        }

        let informationView = constructInformationView()
        constructNameLabel(informationView: informationView)
    }

    func constructInformationView() -> UIView {
        let bottomHeight: CGFloat = 60.0
        let bottomFrame: CGRect = CGRect(
            x: 0, y: self.bounds.height - bottomHeight,
            width: self.bounds.width, height: bottomHeight
        )
        let informationView = UIView(frame: bottomFrame)
        informationView.backgroundColor = .white
        informationView.clipsToBounds = true
        informationView.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        self.addSubview(informationView)

        return informationView
    }

    func constructNameLabel(informationView: UIView) {
        let leftPadding: CGFloat = 12.0
        let topPadding: CGFloat = 17.0
        let frame: CGRect = CGRect(
            x: leftPadding, y: topPadding,
            width: floor(informationView.frame.width/2), height: informationView.frame.height - topPadding
        )
        let nameLabel = UILabel(frame: frame)
        nameLabel.text = data.title
        informationView.addSubview(nameLabel)
    }
}
