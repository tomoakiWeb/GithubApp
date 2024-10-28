#if DEBUG
import Foundation
import ShareModel

public extension GithubClient {
    static let mock = Self(
        searchUsersRepos: { _, _ in SearchUsersResponse.mock() },
        fetchUserDetail: { _ in UserDetailResponse.mock()},
        fetchUserDetailRepos: { _, _ in UserDetailReposResponse.mockArray()}
    )
}
#endif
