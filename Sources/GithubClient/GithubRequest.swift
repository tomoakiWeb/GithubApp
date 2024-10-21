import Foundation
import ApiClient

protocol GithubRequest: BaseRequest {
    
}

extension GithubRequest {
    var url: URL { URL(string: "https://api.github.com")! }
    var headers: [String: String] { baseHeaders }
    var decoder: JSONDecoder { JSONDecoder() }

    var baseHeaders: [String: String] {
        var params: [String: String] = [:]
        params["Accept"] = "application/vnd.github+json"
        params["Authorization"] = "Bearer access token"
        return params
    }
}
