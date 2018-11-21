import Foundation

public final class UserInfo {
    private static let keyUserInfoId = "KEY_USER_INFO_ID"
    private static let keyUserInfoPass = "KEY_USER_INFO_PASS"
    private static var userInfo: UserInfo?

    public let id: String
    public let pass: String

    init(id: String, pass: String) {
        self.id = id
        self.pass = pass
    }

    public static func getInfo() -> UserInfo? {
        if let userInfo = userInfo {
            return userInfo
        }
        guard let id = UserDefaults.standard.string(forKey: keyUserInfoId),
            let pass = UserDefaults.standard.string(forKey: keyUserInfoPass),
            !id.isEmpty, !pass.isEmpty else {
                resetInfo()
                return nil
        }
        return UserInfo(id: id, pass: pass)
    }

    public func saveInfo() {
        UserDefaults.standard.set(self.id, forKey: type(of: self).keyUserInfoId)
        UserDefaults.standard.set(self.pass, forKey: type(of: self).keyUserInfoPass)
    }
    public static func resetInfo() {
        UserDefaults.standard.set(nil, forKey: keyUserInfoId)
        UserDefaults.standard.set(nil, forKey: keyUserInfoPass)
        self.userInfo = nil
    }
}
