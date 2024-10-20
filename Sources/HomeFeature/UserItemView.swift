import SwiftUI
import ComposableArchitecture

struct UserItemView: View {
    @Bindable var store: StoreOf<UserItemReducer>
    
    var body: some View {
        Text("UserItemView")
    }
}

#Preview {
    UserItemView(
        store: .init(initialState: UserItemReducer.State()) {
            UserItemReducer()
        }
    )
}

