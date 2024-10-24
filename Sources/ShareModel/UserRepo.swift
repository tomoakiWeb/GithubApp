import Foundation

public struct UserRepo: Equatable, Sendable {
    public let id: Int
    public let name: String
    public let avatarUrl: URL
}

public extension UserRepo {
    init (from item: SearchUsersResponse.Item) {
        self.id = item.id
        self.name = item.login
        self.avatarUrl = item.avatarUrl
    }
}
