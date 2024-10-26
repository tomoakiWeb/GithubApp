import Foundation

public struct UserDetailItem: Equatable, Sendable {
    public let id: Int
    public let name: String
    public let fork: Bool
    public let description: String?
    public let stargazersCount: Int
    public let language: String?
    public let htmlUrl: String
}

public extension UserDetailItem {
    init (from response: UserDetailReposResponse) {
        self.id = response.id
        self.name = response.name
        self.fork = response.fork
        self.description = response.description
        self.stargazersCount = response.stargazersCount
        self.language = response.language
        self.htmlUrl = response.htmlUrl
    }
}
