import SwiftUI
import ComposableArchitecture
import Kingfisher

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
                        state: \.items,
                        action: \.items
                    )) { itemStore in
                        UserDetailItemView(store: itemStore)
                    }
                }
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
                                                                                        following: 6)),
                            reducer: {
        DetailReducer()
    }))
}
