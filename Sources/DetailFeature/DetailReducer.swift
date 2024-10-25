import ComposableArchitecture
import Dependencies
import Foundation

@Reducer
public struct DetailReducer: Reducer, Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        public init() {}
    }

    public init() {}

    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
    }
}
