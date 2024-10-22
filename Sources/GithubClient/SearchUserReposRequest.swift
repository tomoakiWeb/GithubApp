import Foundation
import ApiClient
import ShareModel

struct SearchUserReposRequest: GithubRequest {
    typealias Response = SearchUsersResponse
    let queryParameters: [String: String]?
    let path = "/search/repositories"
    var url: URL { URL(string: "https://api.github.com/search/users")! }

    public init(query: String, page: Int) {
        self.queryParameters = [
            "q": query,
            "page": page.description,
            "per_page": "20"
        ]
    }
}
