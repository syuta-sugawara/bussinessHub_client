import UIKit
import MDCSwipeToChoose
import RxSwift
import RxCocoa
import NSObject_Rx
import SVProgressHUD

public struct FrontCardHolder {
    let view: ImageSelectionView
    let data: ImageSelectionViewController.DataType
}

class ImageSelectionViewController: UIViewController {
    typealias DataType = ImageResponse
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var cardContentView: UIView!

    var projectData: ClassificationResponse!
    var dataList: [DataType] = []
    var frontCardHolder: FrontCardHolder!
    var backCardView: ImageSelectionView!

    var frontCardViewFrame: CGRect {
        let horizontalPadding: CGFloat = 0.0
        let topPadding: CGFloat = 0.0
        let bottomPadding: CGFloat = 0.0
        return CGRect(x: horizontalPadding,
                      y: topPadding,
                      width: cardContentView.frame.width - (horizontalPadding * 2),
                      height: cardContentView.frame.height - bottomPadding)
    }
    var backCardViewFrame: CGRect {
        let frontFrame: CGRect = self.frontCardViewFrame
        return CGRect(x: frontFrame.origin.x,
                      y: frontFrame.origin.y + 10.0,
                      width: frontFrame.width,
                      height: frontFrame.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let data = popData() else {
            return
        }
        let frontCardView = self.newDataView(frame: self.frontCardViewFrame, data: data)
        let frontCardHolder = FrontCardHolder(view: frontCardView, data: data)
        self.frontCardHolder = frontCardHolder
        self.cardContentView.addSubview(frontCardView)

        guard let backCardData = popData() else {
            return
        }
        let backCardView = newDataView(frame: self.backCardViewFrame, data: backCardData)
        self.backCardView = backCardView
        self.cardContentView.insertSubview(backCardView, belowSubview: frontCardView)
    }

    func suportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }

    func popData() -> DataType? {
        guard !self.dataList.isEmpty else {
            return nil
        }
        return self.dataList.remove(at: 0)
    }

    func newDataView(frame: CGRect, data: DataType) -> ImageSelectionView {
        let options: MDCSwipeToChooseViewOptions = MDCSwipeToChooseViewOptions()
        options.delegate = self
        options.threshold = 160
        options.likedText = projectData.selectionTypes[0].title
        options.nopeText = projectData.selectionTypes[1].title
        options.onPan = { [weak wself = self] state -> Void in
            guard let backCardView = wself?.backCardView else { return }
            guard let state = state else { return }
            guard var frontCardViewFrame = wself?.frontCardViewFrame else { return }
            guard state.direction != .none else {
                self.frontCardHolder.view.transform = CGAffineTransform.identity
                self.frontCardHolder.view.frame = frontCardViewFrame
                return
            }

            frontCardViewFrame.origin.y -= (state.thresholdRatio * 10.0)
            backCardView.frame = frontCardViewFrame
        }
        return ImageSelectionView(frame: frame, data: data, options: options)
    }

}

extension ImageSelectionViewController: MDCSwipeToChooseDelegate {
    func view(_ view: UIView, wasChosenWith wasChosenWithDirection: MDCSwipeDirection) {
        guard let frontCardHolder = self.frontCardHolder else {
            return
        }

        switch wasChosenWithDirection {
        case .left:
            ImagesRepository.postImageSelection(id: projectData.id, imageId: frontCardHolder.data.id, selectionId: projectData.selectionTypes[1].id) { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    SVProgressHUD.showError(withStatus: error.message)
                }
            }
            print("You noped: \(frontCardHolder.data.title)")
        case .right:
            ImagesRepository.postImageSelection(id: projectData.id, imageId: frontCardHolder.data.id, selectionId: projectData.selectionTypes[0].id) { result in
                switch result {
                case .success:
                    break
                case let .failure(error):
                    SVProgressHUD.showError(withStatus: error.message)
                }
            }
            print("You liked: \(frontCardHolder.data.title)")
        case .none:
            break
        }

        guard let oldBackCardView = self.backCardView else { return }
        let newFrontCardHolder = FrontCardHolder(view: oldBackCardView, data: oldBackCardView.data)
        self.frontCardHolder = newFrontCardHolder

        if let data = popData() {
            let newBackCardView = self.newDataView(frame: self.backCardViewFrame, data: data)
            self.backCardView = newBackCardView
            newBackCardView.alpha = 0.0
            self.cardContentView.insertSubview(newBackCardView, belowSubview: newFrontCardHolder.view)
            UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseInOut, animations: {
                newBackCardView.alpha = 1.0
            }, completion: nil)
        } else {
            self.backCardView = nil
        }
    }
    public func viewDidCancelSwipe(_ view: UIView) {
        guard let frontCardHolder = self.frontCardHolder else {
            return
        }
        print("You couldn't decide on \(frontCardHolder.data.title)")
    }
    public func view(_ view: UIView!, shouldBeChosenWith direction: MDCSwipeDirection) -> Bool {
        return direction != .none
    }
}
