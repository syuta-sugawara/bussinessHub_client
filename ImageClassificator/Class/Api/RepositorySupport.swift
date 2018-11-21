import Foundation
import ObjectMapper

public final class ErrorMessageResponse: Mappable {
    var errorMessage: String!

    public required init?(map: Map) {
        guard map.JSON["error_message"] != nil else { return nil}
    }

    public func mapping(map: Map) {
        errorMessage <- map["error_message"]
    }
}

public struct ErrorResult: Swift.Error {
    /// The underlying error.
    public let message: String

    public init(_ message: String? = nil) {
        if let message = message {
            self.message = message
        } else {
            self.message = "通信エラーです"
        }
    }
}
