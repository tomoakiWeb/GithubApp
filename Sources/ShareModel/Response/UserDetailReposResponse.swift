import Foundation

public struct UserDetailReposResponse: Sendable, Decodable, Equatable {
    public let id: Int
    public let name: String
    public let fork: Bool
    public let description: String?
    public let stargazersCount: Int
    public let language: String?
    public let htmlUrl: String

    public init(
        id: Int,
        name: String,
        fork: Bool,
        description: String?,
        stargazersCount: Int,
        language: String?,
        htmlUrl: String
    ) {
        self.id = id
        self.name = name
        self.fork = fork
        self.description = description
        self.stargazersCount = stargazersCount
        self.language = language
        self.htmlUrl = htmlUrl
    }

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fork
        case description
        case stargazersCount = "stargazers_count"
        case language
        case htmlUrl = "html_url"
    }
}

public extension UserDetailReposResponse {
    static func mock(
        id: Int,
        name: String,
        fork: Bool,
        description: String?,
        stargazersCount: Int,
        language: String?,
        htmlUrl: String
    ) -> Self {
        .init(
            id: id,
            name: name,
            fork: fork,
            description: description,
            stargazersCount: stargazersCount,
            language: language,
            htmlUrl: htmlUrl
        )
    }
}

