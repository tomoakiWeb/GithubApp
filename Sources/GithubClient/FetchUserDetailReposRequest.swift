import Foundation
import ApiClient
import ShareModel

struct FetchUserDetailReposRequest: GithubRequest {
    typealias Response = [UserDetailReposResponse]
    var path: String
    var queryParameters: [String : String]?

    public init(name: String) {
        self.path = "users/\(name)/repos"
    }
}
