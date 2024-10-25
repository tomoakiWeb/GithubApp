import SwiftUI
import ComposableArchitecture
import Kingfisher

struct UserItemView: View {
    @Bindable var store: StoreOf<UserItemReducer>
    
    var body: some View {
        HStack(spacing: 8) {
            KFImage(store.userRepo.avatarUrl)
                .placeholder {
                    Rectangle()
                        .fill(Color.gray.opacity(0.3))
                }
                .resizable()
                .frame(width: 32, height: 32)
                .cornerRadius(8)
            
            Text(store.userRepo.name)
                .foregroundStyle(.black)
                .lineLimit(2)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview("show avatar") {
    UserItemView(
        store: .init(initialState: UserItemReducer.State(userRepo: .init(from: .mock(id: 1, login: "tomoakiWeb")))) {
            UserItemReducer()
        }
    )
}

#Preview("long name") {
    UserItemView(
        store: .init(initialState: UserItemReducer.State(userRepo: .init(from: .mock(id: 1, login: "longNamelongNamelongNamelongNamelongNamelongNamelongNamelongNamelongName")))) {
            UserItemReducer()
        }
    )
}
