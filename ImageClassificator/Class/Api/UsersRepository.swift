import Foundation
import Alamofire
import AlamofireObjectMapper

public final class UsersRepository {
    public typealias UserResponseResult = ResultResult<UserResponse, ErrorResult>

    /**
     * /users/me
     */
    public static func postMe(id: String, pass: String, completion: @escaping (UserResponseResult) -> Void) {
        let parameters = [
            "id": id,
            "pass": pass
        ]

        ApiClient.defaultSessionManager.request(ApiConstants.baseUrl + "/users/me", method: .post, parameters: parameters)
                .validate()
                .responseObject { (response: DataResponse<UserResponse>) in
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
