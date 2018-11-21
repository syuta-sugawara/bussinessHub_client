import Foundation
import ObjectMapper

public final class ImagesResponse: Mappable {
    var results: [ImageResponse]!

    public required init?(map: Map) {
        guard map.JSON["results"] != nil else {
                return nil
        }
    }

    public func mapping(map: Map) {
        results <- map["results"]
    }
}

public final class ImageResponse: Mappable {
    var id: Int!
    var title: String!
    var description: String!
    var imageUrl: String!
    var classification: Int!
    var updatedAt: String!
    var createdAt: String!

    public required init?(map: Map) {
        guard map.JSON["id"] != nil, map.JSON["title"] != nil,
            map.JSON["description"] != nil, map.JSON["image_url"] != nil,
            map.JSON["classification"] != nil, map.JSON["updated_at"] != nil,
            map.JSON["created_at"] != nil else {
                return nil
        }
    }

    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        imageUrl <- map["image_url"]
        classification <- map["classification"]
        updatedAt <- map["updated_at"]
        createdAt <- map["created_at"]
    }
}


