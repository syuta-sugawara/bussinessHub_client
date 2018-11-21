import Foundation

public final class AppDelegateAccessor {
    public static var initialViewController: InitialViewController! {
        return UIApplication.shared.delegate?.window??.rootViewController as? InitialViewController
    }
}
