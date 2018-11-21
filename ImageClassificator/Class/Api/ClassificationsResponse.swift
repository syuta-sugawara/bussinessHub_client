import Foundation
import ObjectMapper

public final class ClassificationsResponse: Mappable {
    var count: Int!
    var next: String?
    var previous: String?
    var results: [ClassificationResponse]!

    public required init?(map: Map) {
        guard map.JSON["count"] != nil, map.JSON["results"] != nil else {
            return nil
        }
    }

    public func mapping(map: Map) {
        count <- map["count"]
        next <- map["next"]
        previous <- map["previous"]
        results <- map["results"]
    }
}

public final class ClassificationResponse: Mappable {
    var id: Int!
    var title: String!
    var selectionTypes: [ClassificationSelectionTypeResponse]!
    var description: String!
    var updatedAt: String!
    var createdAt: String!

    public required init?(map: Map) {
        guard map.JSON["id"] != nil, map.JSON["title"] != nil,
            map.JSON["selection_types"] != nil, map.JSON["description"] != nil,
            map.JSON["updated_at"] != nil, map.JSON["created_at"] != nil else {
                return nil
        }

    }

    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        selectionTypes <- map["selection_types"]
        description <- map["description"]
        updatedAt <- map["updated_at"]
        createdAt <- map["created_at"]
    }
}

public final class ClassificationSelectionTypeResponse: Mappable {
    var id: Int!
    var title: String!
    var description: String!
    var classification: Int!
    var updatedAt: String!
    var createdAt: String!

    public required init?(map: Map) {
        guard map.JSON["id"] != nil, map.JSON["title"] != nil,
            map.JSON["description"] != nil, map.JSON["classification"] != nil,
            map.JSON["updated_at"] != nil, map.JSON["created_at"] != nil else {
                return nil
        }
    }

    public func mapping(map: Map) {
        id <- map["id"]
        title <- map["title"]
        description <- map["description"]
        classification <- map["classification"]
        updatedAt <- map["updated_at"]
        createdAt <- map["created_at"]
    }
}
