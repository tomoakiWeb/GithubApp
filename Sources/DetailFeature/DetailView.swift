import SwiftUI
import ComposableArchitecture
import Kingfisher
import WebRepoFeature
import GithubClient

public struct DetailView: View {
    @Bindable var store: StoreOf<DetailReducer>
    
    public init(store: StoreOf<DetailReducer>) {
        self.store = store
    }

    public var body: some View {
        ZStack {
            ScrollView {
                LazyVStack(spacing: 0) {
                    if let userDetail = store.userDetail {
                        VStack {
                            UserDetailView(userDetail: userDetail)
                        }
                        .padding(16)
                    }
                    
                    ForEach(store.scope(
                        state: \.items,
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
            if store.isLoading {
                ProgressView()
                    .frame(maxWidth: .infinity)
            }
        }
        .onAppear { store.send(.onAppear) }
        .navigationBarTitleDisplayMode(.inline)
        .alert(
            "エラーが発生しました",
            isPresented: $store.showErrorDialog,
            presenting: store.errorMessage
        ) { _ in
            Button("閉じる", role: .cancel) {}
        } message: { message in
            Text(message)
        }
    }
}

#Preview {
    DetailView(
        store: .init(initialState: DetailReducer.State(name: "tomoakiWeb"),
            reducer: {
                DetailReducer()
                    .dependency(
                        \.githubClient,
                        .mock
                    )
            }
        )
    )
}
