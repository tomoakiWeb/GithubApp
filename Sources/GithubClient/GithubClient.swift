import Dependencies
import DependenciesMacros
import ApiClient
import ShareModel

@DependencyClient
public struct GithubClient: Sendable {
    public var searchUsersRepos: @Sendable (_ query: String, _ page: Int) async throws -> SearchUsersResponse
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
        .init { query, page in
            try await apiClient.send(request: SearchUserReposRequest(query: query, page: page))
        }
    }
}