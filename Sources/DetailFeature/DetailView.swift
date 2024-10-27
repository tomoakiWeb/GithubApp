import SwiftUI
import ComposableArchitecture
import Kingfisher
import WebRepoFeature

public struct DetailView: View {
    @Bindable var store: StoreOf<DetailReducer>
    
    public init(store: StoreOf<DetailReducer>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            ScrollView {
                LazyVStack {
                    if let userDetail = store.userDetail {
                        VStack {
                            UserDetailView(userDetail: userDetail)
                        }
                        .padding(16)
                    }
                    
                    ForEach(store.scope(
                        state: \.filteredItems,
                        action: \.items
                    )) { itemStore in
                        
                        Button {
                            store.send(.userDetailItemTapped(itemStore.userDetailItem.htmlUrl))
                        } label: {
                            UserDetailItemView(store: itemStore)
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
            if store.loadingState == .refreshing {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear { store.send(.onAppear) }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    DetailView(store: .init(initialState: DetailReducer.State(name: "tomoakiWeb",
                                                              userDetailResponse: .mock(id: 1,
                                                                                        login: "tomo",
                                                                                        name: "full name",
                                                                                        followers: 12,
                                                                                        following: 6,
                                                                                        publicRepos: 12)),
                            reducer: {
        DetailReducer()
    }))
}
