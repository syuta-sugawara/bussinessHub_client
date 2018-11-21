import Foundation
import Alamofire

public final class ApiClient {
    public static var defaultSessionManager = Alamofire.SessionManager.default

    public static func setBasicAuthInfo(userInfo: UserInfo?) {
        let manager = defaultSessionManager
        manager.session.getAllTasks { tasks in
            tasks.forEach { $0.cancel() }
        }

        var header = Alamofire.SessionManager.defaultHTTPHeaders
        if let userInfo = userInfo {
            let plainString = "\(userInfo.id):\(userInfo.pass)"
            if let plainData = plainString.data(using: .utf8) {
                let base64String = plainData.base64EncodedString()
                header["Authorization"] = "Basic \(base64String)"
            }
        }
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = header
        defaultSessionManager = Alamofire.SessionManager(configuration: configuration)
    }
}
