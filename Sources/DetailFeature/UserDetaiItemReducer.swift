import ComposableArchitecture
import Foundation
import ShareModel

@Reducer
public struct UserDetailItemReducer: Reducer, Sendable {
    @ObservableState
    public struct State: Equatable, Identifiable, Sendable {
        public var id: Int { userDetailItem.id }
        let userDetailItem: UserDetailItem
        
        static func make(from item: UserDetailReposResponse) -> Self {
            .init(userDetailItem: .init(from: item))
        }
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

extension IdentifiedArrayOf where Element == UserDetailItemReducer.State, ID == Int {
    init(responses: [UserDetailReposResponse]) {
        self = IdentifiedArrayOf(uniqueElements: responses.map { .make(from: $0) })
    }
}

