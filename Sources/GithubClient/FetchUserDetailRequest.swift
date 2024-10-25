import Foundation
import ApiClient
import ShareModel

struct FetchUserDetailRequest: GithubRequest {
    typealias Response = UserDetailResponse
    var path: String
    var queryParameters: [String : String]?

    public init(name: String) {
        self.path =  "users/\(name)"
    }
}

