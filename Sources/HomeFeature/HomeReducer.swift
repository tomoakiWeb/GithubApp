import ComposableArchitecture

@Reducer
public struct HomeReducer: Reducer, Sendable {
    
    @ObservableState
    public struct State: Equatable, Sendable {
        var query = ""
        
        public init() {}
    }
    
    public enum Action: BindableAction, Sendable {
        case binding(BindingAction<State>)
    }
    
    public init() {}

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
