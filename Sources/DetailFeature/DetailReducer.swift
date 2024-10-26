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
        case fetchUserDetail
        case userDetailResponse(Result<UserDetailResponse, Error>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
            case .onAppear:
                state.isLoading = true
                return .run { send in
                    await send(.fetchUserDetail)
                }
            case .fetchUserDetail:
                return .run { [name = state.name] send in
                    await send(.userDetailResponse(Result {
                        try await githubClient.fetchUserDetail(name: name)
                    }))
                }
            case let .userDetailResponse(.success(response)):
                state.userDetail = .init(from: response)
                return .none
            case .userDetailResponse(.failure(_)):
                return .none
            }
        }
    }
}
