#if DEBUG
import Foundation

public extension UserDetailResponse {
    static func mock() -> Self {
        .init(id: 0,
              login: "username",
              avatarUrl: URL(string: "https://www.apple.com/jp/")!,
              name: "fullname",
              followers: 1000,
              following: 2000,
              publicRepos: 30)
    }
}
#endif
