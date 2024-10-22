import Foundation

public struct SearchUsersResponse: Sendable, Decodable, Equatable {
    public let totalCount: Int
    public let items: [Item]

    public init(
        totalCount: Int,
        items: [Item]
    ) {
        self.totalCount = totalCount
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items
    }

    public struct Item: Sendable, Decodable, Equatable {
        public let id: Int
        public let login: String
        public let avatarUrl: URL

        public init(
            id: Int,
            login: String,
            avatarUrl: URL
        ) {
            self.id = id
            self.login = login
            self.avatarUrl = avatarUrl
        }

        enum CodingKeys: String, CodingKey {
            case id
            case login
            case avatarUrl = "avatar_url"
        }
    }
}
