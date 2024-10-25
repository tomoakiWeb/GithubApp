import SwiftUI
import ComposableArchitecture

public struct DetailView: View {
    @Bindable var store: StoreOf<DetailReducer>
    
    public init(store: StoreOf<DetailReducer>) {
        self.store = store
    }

    public var body: some View {
        Text("DetailView")
            .padding()
    }
}

#Preview {
    DetailView(store: .init(initialState: DetailReducer.State(), reducer: {
        DetailReducer()
    }))
}
