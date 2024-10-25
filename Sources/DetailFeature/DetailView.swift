import SwiftUI
import ComposableArchitecture

public struct DetailView: View {
    @Bindable var store: StoreOf<DetailReducer>
    
    public init(store: StoreOf<DetailReducer>) {
        self.store = store
    }

    public var body: some View {
        Text(store.userDetail?.name ?? "")
            .padding()
            .onAppear { store.send(.onAppear) }
    }
}

#Preview {
    DetailView(store: .init(initialState: DetailReducer.State(name: "tomoakiWeb"), reducer: {
        DetailReducer()
    }))
}
