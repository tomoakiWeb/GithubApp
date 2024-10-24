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
                    ForEach(store.scope(
                        state: \.items,
                        action: \.items
                    )) { itemStore in
                        UserItemView(store: itemStore)
                            .onAppear {
                                store.send(.itemAppeared(id:itemStore.id))
                            }
                    }
                    if store.hasMorePage {
                        ProgressView()
                            .frame(maxWidth: .infinity)
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
