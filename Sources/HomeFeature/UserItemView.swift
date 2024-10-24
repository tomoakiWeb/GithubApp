import SwiftUI
import ComposableArchitecture

struct UserItemView: View {
    @Bindable var store: StoreOf<UserItemReducer>
    
    var body: some View {
        Text(store.userRepo.name)
    }
}

#Preview {
    UserItemView(
        store: .init(initialState: UserItemReducer.State(userRepo: .init(from: .mock(id: 1, login: "test user")))) {
            UserItemReducer()
        }
    )
}

