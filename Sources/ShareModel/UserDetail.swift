import Foundation

public struct UserDetail: Equatable, Sendable {
    public let id: Int
    public let name: String
    public let avatarUrl: URL
    public let fullName: String?
    public let followers: Int
    public let following: Int
    public let publicRepos: Int
}

public extension UserDetail {
    init (from response: UserDetailResponse) {
        self.id = response.id
        self.name = response.login
        self.avatarUrl = response.avatarUrl
        self.fullName = response.name
        self.followers = response.followers
        self.following = response.following
        self.publicRepos = response.publicRepos
    }
}

