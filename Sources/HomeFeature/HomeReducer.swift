import ComposableArchitecture
import Dependencies
import GithubClient
import ShareModel

@Reducer
public struct HomeReducer: Reducer, Sendable {
    
    @ObservableState
    public struct State: Equatable, Sendable {
        var items = IdentifiedArrayOf<UserItemReducer.State>()
        var query = ""
        var hasMorePage = false
        var currentPage = 1
        public init() {}
    }
    
    private enum CancelId { case searchUserRepos }
    
    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
        case itemAppeared(id: Int)
        case items(IdentifiedActionOf<UserItemReducer>)
        case searchUserReposResponse(Result<SearchUsersResponse, Error>)
    }
    
    @Dependency(\.githubClient) var githubClient
    @Dependency(\.mainQueue) var mainQueue
    
    public init() {}

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                
            case .binding(\.query):
                print("test:binding:\(state.query)")
                guard !state.query.isEmpty else {
                    state.hasMorePage = false
                    state.items.removeAll()
                    return .cancel(id: CancelId.searchUserRepos)
                }

                state.currentPage = 1

                return .run { [query = state.query, page = state.currentPage] send in
                    await send(.searchUserReposResponse(Result {
                        try await githubClient.searchUsersRepos(query: query, page: page)
                    }))
                }
                .debounce(id: CancelId.searchUserRepos, for: 0.3, scheduler: mainQueue)
                
            case .binding:
                print("test:binding:none")
                return .none
                
            case .itemAppeared(id: let id):
                if state.hasMorePage, state.items.index(id: id) == state.items.count - 1 {
                    state.currentPage += 1
                    return .run { [query = state.query, page = state.currentPage] send in
                        await send(.searchUserReposResponse(Result {
                            try await githubClient.searchUsersRepos(query: query, page: page)
                        }))
                    }
                } else {
                    return .none
                }
        
            case let .searchUserReposResponse(.success(response)):
                state.items = .init(response: response)
                return .none
                
            case .searchUserReposResponse(.failure):
                return .none
                
            case .items:
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            UserItemReducer()
        }
    }
}
