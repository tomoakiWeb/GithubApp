import SwiftUI
import ComposableArchitecture
import Kingfisher

struct UserDetailItemView: View {
    @Bindable var store: StoreOf<UserDetailItemReducer>
    
    var body: some View {
        Text(store.userDetailItem.name)
            .padding()
    }
}

#Preview {
    UserDetailItemView(store: .init(initialState: UserDetailItemReducer.State(userDetailItem: .init(from: .mock(id: 1,
                                                                                                                name: "repo name",
                                                                                                                fork: false,
                                                                                                                description: "description",
                                                                                                                stargazersCount: 3,
                                                                                                                language: "Swift",
                                                                                                                htmlUrl: "https://github.com/tomoakiWeb/GithubApp"))),
                                    reducer: {
        UserDetailItemReducer()
    }))
}
