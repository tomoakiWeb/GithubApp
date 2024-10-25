import ComposableArchitecture
import Dependencies
import Foundation

@Reducer
public struct DetailReducer: Reducer, Sendable {
    @ObservableState
    public struct State: Equatable, Sendable {
        public let name: String
        public init(name: String) {
            self.name = name
        }
    }

    public init() {}

    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()
    }
}
