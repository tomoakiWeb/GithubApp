import SwiftUI
import DetailFeature
import ComposableArchitecture

public struct HomeView: View {
    @Bindable var store: StoreOf<HomeReducer>
    
    public init(store: StoreOf<HomeReducer>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    Text("User Name")
                        .onAppear {
                            store.send(.itemAppeared(id:1))
                        }
                }
            }
        }
        .searchable(text: $store.query)
    }
}

#Preview {
    HomeView(
        store: .init(initialState: HomeReducer.State()) {
            HomeReducer()
        }
    )
}
