import ComposableArchitecture
import Foundation

@Reducer
public struct UserItemReducer: Reducer, Sendable {
    @ObservableState
    public struct State: Equatable, Identifiable, Sendable {
        public var id: Int { Int.random(in: 1...1000) }
        public init() {}
    }

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
