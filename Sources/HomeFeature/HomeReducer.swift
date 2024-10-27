import ComposableArchitecture
import Dependencies
import GithubClient
import ShareModel
import DetailFeature
import WebRepoFeature

@Reducer
public struct HomeReducer: Reducer, Sendable {
    
    @Reducer
    public enum Path {
        case detail(DetailReducer)
        case webRepo(WebRepoReducer)
    }
    
    @ObservableState
    public struct State: Equatable {
        var items = IdentifiedArrayOf<UserItemReducer.State>()
        var query = ""
        var hasMorePage = false
        var currentPage = 1
        var loadingState: LoadingState = .refreshing
        var path = StackState<Path.State>()
        
        public init() {}
    }
    
    enum LoadingState: Equatable {
        case refreshing
        case loadingNext
        case none
    }
    
    private enum CancelId { case searchUserRepos }
    
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case itemAppeared(id: Int)
        case items(IdentifiedActionOf<UserItemReducer>)
        case searchUserReposResponse(Result<SearchUsersResponse, Error>)
        case path(StackActionOf<Path>)
        case userItemTapped(String)
        case webRepoRequested(String)
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
                state.loadingState = .refreshing

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
                    state.loadingState = .loadingNext
                    return .run { [query = state.query, page = state.currentPage] send in
                        await send(.searchUserReposResponse(Result {
                            try await githubClient.searchUsersRepos(query: query, page: page)
                        }))
                    }
                } else {
                    return .none
                }
        
            case let .searchUserReposResponse(.success(response)):
                switch state.loadingState {
                case .refreshing:
                    state.items = .init(response: response)
                case .loadingNext:
                    let newItems = IdentifiedArrayOf(response: response)
                    state.items.append(contentsOf: newItems)
                case .none:
                    break
                }

                state.hasMorePage = response.totalCount > state.items.count
                state.loadingState = .none
                return .none
                
            case .searchUserReposResponse(.failure):
                return .none
                
            case .items:
                return .none
                
            case let .userItemTapped(name):
                state.path.append(.detail(DetailReducer.State(name: name)))
                return .none
                
            case let .path(.element(_, .detail(.pushWebRepo(url)))):
                state.path.append(.webRepo(WebRepoReducer.State(repoUrl: url)))
                return .none
            case .path:
                return .none
                
            case .webRepoRequested(_):
                return .none
            }
        }
        .forEach(\.items, action: \.items) {
            UserItemReducer()
        }
        .forEach(\.path, action: \.path)
    }
}

extension HomeReducer.Path.State: Equatable {}
