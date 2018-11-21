import Foundation
import Alamofire
import AlamofireObjectMapper

public final class ClassificationsRepository {
    public typealias ClassificationsResponseResult = ResultResult<ClassificationsResponse, ErrorResult>

    /**
     * /classifications
     */
    public static func get(completion: @escaping (ClassificationsResponseResult) -> Void) {
        ApiClient.defaultSessionManager.request(ApiConstants.baseUrl + "/classifications", method: .get)
            .validate()
            .responseObject { (response: DataResponse<ClassificationsResponse>) in
                switch response.result {
                case let .success(value):
                    completion(.success(value))
                case .failure:
                    let jsonString = String(data: response.data ?? Data(), encoding: .utf8) ?? ""
                    let message = ErrorMessageResponse(JSONString: jsonString)
                    completion(.failure(ErrorResult(message?.errorMessage)))
                }
        }
    }
}
