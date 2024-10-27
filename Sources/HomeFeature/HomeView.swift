import SwiftUI
import DetailFeature
import ComposableArchitecture
import WebRepoFeature

public struct HomeView: View {
    @Bindable var store: StoreOf<HomeReducer>
    
    public init(store: StoreOf<HomeReducer>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            ScrollView {
                LazyVStack {
                    ForEach(store.scope(
                        state: \.items,
                        action: \.items
                    )) { itemStore in
                        Button {
                            store.send(.userItemTapped(itemStore.userRepo.name))
                        } label: {
                            UserItemView(store: itemStore)
                                .contentShape(Rectangle())
                                .onAppear {
                                    store.send(.itemAppeared(id:itemStore.id))
                                }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    if store.hasMorePage {
                        ProgressView()
                            .frame(maxWidth: .infinity)
                    }
                }
            }
        } destination: { store in
            switch store.case {
            case let .detail(store):
                DetailView(store: store)
            case let .webRepo(store):
                WebRepoView(store:store)
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
