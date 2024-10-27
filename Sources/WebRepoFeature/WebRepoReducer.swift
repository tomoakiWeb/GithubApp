import ComposableArchitecture
import Foundation
import ShareModel

@Reducer
public struct WebRepoReducer: Reducer, Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        public let repoUrl: String
        
        public init(repoUrl: String) {
            self.repoUrl = repoUrl
        }
    }
    
    public init() {}

    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
        Reduce { state, action in
            switch action {
                case .binding:
                return .none
            }
        }
    }
}

