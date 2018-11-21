import Foundation
import Rswift

extension Bundle {
    open class var library: Bundle {
        return LibraryBundle.bundle
    }
}

private class LibraryBundle {
    public static var bundle: Bundle {
        return Bundle.init(for: LibraryBundle.self)
    }
}

extension StoryboardResourceWithInitialControllerType {
    public func instantiateInitialVC() -> InitialController {
        let vc: InitialController! = UIStoryboard(resource: self).instantiateInitialViewController() as? InitialController
        return vc
    }
}
