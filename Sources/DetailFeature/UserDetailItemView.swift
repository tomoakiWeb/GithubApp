import SwiftUI
import ComposableArchitecture
import Kingfisher

struct UserDetailItemView: View {
    @Bindable var store: StoreOf<UserDetailItemReducer>
    
    var body: some View {
        Text("UserDetailItemView")
    }
}
