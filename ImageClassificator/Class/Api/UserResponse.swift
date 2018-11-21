import Foundation
import ObjectMapper

public final class UserResponse: Mappable {
    var id: Int!
    var username: String!
    var email: String!
    var firstName: String!
    var lastName: String!
    var dateJoined: String!

    public required init?(map: Map) {
        guard map.JSON["id"] != nil, map.JSON["username"] != nil,
            map.JSON["email"] != nil, map.JSON["first_name"] != nil,
            map.JSON["last_name"] != nil, map.JSON["date_joined"] != nil
            else {return nil}
    }

    public func mapping(map: Map) {
        id <- map["id"]
        username <- map["username"]
        email <- map["email"]
        firstName <- map["first_name"]
        lastName <- map["last_name"]
        dateJoined <- map["date_joined"]
    }
}
