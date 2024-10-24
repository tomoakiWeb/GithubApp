import ComposableArchitecture
import Foundation
import ShareModel

@Reducer
public struct UserItemReducer: Reducer, Sendable {
    @ObservableState
    public struct State: Equatable, Identifiable, Sendable {
        public var id: Int { userRepo.id }
        let userRepo: UserRepo
        
        static func make(from item: SearchUsersResponse.Item) -> Self {
            .init(userRepo: .init(from: item))
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

extension IdentifiedArrayOf where Element == UserItemReducer.State, ID == Int {
    init(response: SearchUsersResponse) {
        self = IdentifiedArrayOf(uniqueElements: response.items.map { .make(from: $0) })
    }
}

