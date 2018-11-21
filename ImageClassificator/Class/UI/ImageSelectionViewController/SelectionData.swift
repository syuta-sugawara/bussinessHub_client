import UIKit

class SelectionData: NSObject {

    let name: String
    let image: UIImage?

    override var description: String {
        return "name: \(name), \n"
            + "image: \(String(describing: image)), \n"
    }

    public static func newEmpty() -> SelectionData {
        return SelectionData(name: "", image: nil)
    }

    init(name: String?, image: UIImage?) {
        self.name = name ?? ""
        self.image = image
    }
}
