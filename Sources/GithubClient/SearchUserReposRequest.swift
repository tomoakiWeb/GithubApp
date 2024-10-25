import Foundation
import ApiClient
import ShareModel

struct SearchUserReposRequest: GithubRequest {
    typealias Response = SearchUsersResponse
    var path: String = "search/users"
    let queryParameters: [String: String]?

    public init(query: String, page: Int) {
        self.queryParameters = [
            "q": query,
            "page": page.description,
            "per_page": "20"
        ]
    }
}
