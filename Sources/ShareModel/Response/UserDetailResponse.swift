import Foundation

public struct UserDetailResponse: Sendable, Decodable, Equatable {
    public let id: Int
    public let login: String
    public let avatarUrl: URL
    public let name: String?
    public let followers: Int
    public let following: Int
    public let publicRepos: Int

    public init(
        id: Int,
        login: String,
        avatarUrl: URL,
        name: String?,
        followers: Int,
        following: Int,
        publicRepos: Int
    ) {
        self.id = id
        self.login = login
        self.avatarUrl = avatarUrl
        self.name = name
        self.followers = followers
        self.following = following
        self.publicRepos = publicRepos
    }

    enum CodingKeys: String, CodingKey {
        case id
        case login
        case avatarUrl = "avatar_url"
        case name
        case followers
        case following
        case publicRepos = "public_repos"
    }
}


public extension UserDetailResponse {
    static func mock(id: Int, login: String, name: String?, followers: Int, following: Int, publicRepos: Int) -> Self {
        .init(
            id: id,
            login: login,
            avatarUrl: URL(string: "https://github.com/\(login).png")!,
            name: name,
            followers: followers,
            following: following,
            publicRepos: publicRepos
        )
    }
}

