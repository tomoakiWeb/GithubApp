import SwiftUI
import ComposableArchitecture

public struct DetailView: View {
    @Bindable var store: StoreOf<DetailReducer>
    
    public init(store: StoreOf<DetailReducer>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            Text(store.userDetail?.name ?? "")
                .padding()
                .onAppear { store.send(.onAppear) }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(store: .init(initialState: DetailReducer.State(name: "tomoakiWeb"), reducer: {
        DetailReducer()
    }))
}
