import ComposableArchitecture
import Dependencies
import Foundation
import GithubClient
import ShareModel

@Reducer
public struct DetailReducer: Reducer, Sendable {

    @ObservableState
    public struct State: Equatable, Sendable {
        public let name: String
        public var userDetail: UserDetail?
        var currentPage = 1
        var items = IdentifiedArrayOf<UserDetailItemReducer.State>()
        var filteredItems: IdentifiedArrayOf<UserDetailItemReducer.State> {
            items.filter {
                !$0.userDetailItem.fork
            }
        }
        var loadingState: LoadingState = .refreshing
        var hasMorePage = false

        public init(name: String, userDetailResponse: UserDetailResponse? = nil) {
            self.name = name
            if let userDetailResponse = userDetailResponse {
                self.userDetail = .init(from: userDetailResponse)
            }
        }
    }

    enum LoadingState: Equatable {
        case refreshing
        case loadingNext
        case none
    }

    @Dependency(\.githubClient) var githubClient

    public init() {}

    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case onAppear
        case userDetailAndReposFetched(Result<(UserDetailResponse, [UserDetailReposResponse]), Error>)
        case items(IdentifiedActionOf<UserDetailItemReducer>)
        case itemAppeared(id: Int)
        case userDetailReposResponseResponse(Result<[UserDetailReposResponse], Error>)
        case userDetailItemTapped(String)
        case pushWebRepo(String)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onAppear:
                state.currentPage = 1
                return .run { [name = state.name, page = state.currentPage] send in
                    async let userDetailResult = githubClient.fetchUserDetail(name: name)
                    async let userReposResult = githubClient.fetchUserDetailRepos(name: name, page: page)

                    do {
                        let userDetail = try await userDetailResult
                        let userRepos = try await userReposResult
                        await send(.userDetailAndReposFetched(.success((userDetail, userRepos))))
                    } catch {
                        await send(.userDetailAndReposFetched(.failure(error)))
                    }
                }

            case .itemAppeared(id: let id):
                if let publicRepos = state.userDetail?.publicRepos, publicRepos > state.items.count,
                   state.items.index(id: id) == state.items.count - 1 {
                    state.hasMorePage = true
                    state.currentPage += 1
                    state.loadingState = .loadingNext
                    return .run { [name = state.name, page = state.currentPage] send in
                        await send(.userDetailReposResponseResponse(Result {
                            try await githubClient.fetchUserDetailRepos(name: name, page: page)
                        }))
                    }
                } else {
                    state.hasMorePage = false
                    return .none
                }

            case let .userDetailAndReposFetched(.success((userDetail, userRepos))):
                state.userDetail = .init(from: userDetail)
                state.items = .init(responses: userRepos)
                state.loadingState = .none
                return .none
            case .userDetailAndReposFetched(.failure):
                state.loadingState = .none
                return .none

            case .items:
                return .none

            case let .userDetailItemTapped(url):
                return .send(.pushWebRepo(url))

            case let .userDetailReposResponseResponse(.success(response)):
                state.items.append(contentsOf: response.map { UserDetailItemReducer.State.make(from: $0) })
                return .none

            case .userDetailReposResponseResponse(.failure(_)):
                return .none
                
            case .pushWebRepo:
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            UserDetailItemReducer()
        }
    }
}

