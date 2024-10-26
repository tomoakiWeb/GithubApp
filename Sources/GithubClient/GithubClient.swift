import Dependencies
import DependenciesMacros
import ApiClient
import ShareModel

@DependencyClient
public struct GithubClient: Sendable {
    public var searchUsersRepos: @Sendable (_ query: String, _ page: Int) async throws -> SearchUsersResponse
    public var fetchUserDetail: @Sendable (_ name: String) async throws -> UserDetailResponse
    public var fetchUserDetailRepos: @Sendable (_ name: String) async throws -> [UserDetailReposResponse]
}

extension GithubClient: TestDependencyKey {
    public static let testValue = Self()
    public static let previewValue = Self()
}

public extension DependencyValues {
    var githubClient: GithubClient {
        get { self[GithubClient.self] }
        set { self[GithubClient.self] = newValue }
    }
}

extension GithubClient: DependencyKey {
    public static let liveValue: GithubClient = .live()

    static func live(apiClient: ApiClient = .liveValue) -> Self {
        .init(
            searchUsersRepos: { query, page in
                try await apiClient.send(request: SearchUserReposRequest(query: query, page: page))
            },
            fetchUserDetail: { name in
                try await apiClient.send(request: FetchUserDetailRequest(name: name))
            },
            fetchUserDetailRepos: { name in
                try await apiClient.send(request: FetchUserDetailReposRequest(name: name))
            }
        )
    }
}
