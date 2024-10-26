import Foundation
import ApiClient
import ShareModel

struct FetchUserDetailReposRequest: GithubRequest {
    typealias Response = [UserDetailReposResponse]
    var path: String
    var queryParameters: [String : String]?

    public init(name: String, page: Int) {
        self.path = "users/\(name)/repos"
        self.queryParameters = [
            "page": page.description,
            "per_page": "20"
        ]
    }
}
