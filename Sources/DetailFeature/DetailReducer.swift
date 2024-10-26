import ComposableArchitecture
import Dependencies
import Foundation
import ShareModel
import GithubClient

@Reducer
public struct DetailReducer: Reducer, Sendable {
    
    @ObservableState
    public struct State: Equatable, Sendable {
        public let name: String
        public var userDetail: UserDetail?
        public var isLoading: Bool = false
        var items = IdentifiedArrayOf<UserDetailItemReducer.State>()
        
        public init(name: String, userDetailResponse: UserDetailResponse? = nil) {
            self.name = name
            if let userDetailResponse = userDetailResponse {
                self.userDetail = .init(from: userDetailResponse)
            }
        }
    }
    
    @Dependency(\.githubClient) var githubClient

    public init() {}

    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case onAppear
        case userDetailAndReposFetched(Result<(UserDetailResponse, [UserDetailReposResponse]), Error>)
        case items(IdentifiedActionOf<UserDetailItemReducer>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .onAppear:
                state.isLoading = true
                return .run { [name = state.name] send in
                    async let userDetailResult = githubClient.fetchUserDetail(name: name)
                    async let userReposResult = githubClient.fetchUserDetailRepos(name: name)
                    
                    do {
                        let userDetail = try await userDetailResult
                        let userRepos = try await userReposResult
                        await send(.userDetailAndReposFetched(.success((userDetail, userRepos))))
                    } catch {
                        await send(.userDetailAndReposFetched(.failure(error)))
                    }
                }
            case let .userDetailAndReposFetched(.success((userDetail, userRepos))):
                state.userDetail = .init(from: userDetail)
                state.items = .init(responses: userRepos)
                state.isLoading = false
                return .none
            case .userDetailAndReposFetched(.failure):
                state.isLoading = false
                return .none
            case .items:
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            UserDetailItemReducer()
        }
    }
}
