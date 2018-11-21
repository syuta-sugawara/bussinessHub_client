import Foundation
import Alamofire
import AlamofireObjectMapper

public final class ImagesRepository {
    public typealias ImagesResponseResult = ResultResult<ImagesResponse, ErrorResult>

    /**
     * /classifications/{id}/images
     */
    public static func getClassificationsImages(id: Int, completion: @escaping (ImagesResponseResult) -> Void) {
        let parameters = [
            "id": id
        ]

        ApiClient.defaultSessionManager.request(ApiConstants.baseUrl + "/classifications/\(id)/images", method: .get, parameters: parameters)
            .validate()
            .responseObject { (response: DataResponse<ImagesResponse>) in
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

    public typealias ImagesSelectionResponseResult = ResultResult<ImageResponse, ErrorResult>

    /**
     * /classifications/{id}/images/{imageId}/selection_types/{selectionId}
     */
    public static func postImageSelection(id: Int, imageId: Int, selectionId: Int, completion: @escaping (ImagesSelectionResponseResult) -> Void) {
        ApiClient.defaultSessionManager.request(ApiConstants.baseUrl + "/classifications/\(id)/images/\(imageId)/selection_types/\(selectionId)", method: .post)
            .validate()
            .responseObject { (response: DataResponse<ImageResponse>) in
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
