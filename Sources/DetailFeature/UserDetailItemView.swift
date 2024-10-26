import SwiftUI
import ComposableArchitecture
import Kingfisher

struct UserDetailItemView: View {
    @Bindable var store: StoreOf<UserDetailItemReducer>
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(store.userDetailItem.name)
                .foregroundStyle(.primary)
                .lineLimit(2)
                .font(.title2)
                .fontWeight(.bold)
            
            HStack(spacing: 8) {
                HStack(spacing: 4) {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text("\(store.userDetailItem.stargazersCount)")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                if let language = store.userDetailItem.language {
                    Text(language)
                         .font(.subheadline)
                         .foregroundColor(.secondary)
                 }
            }
            
            if let description = store.userDetailItem.description {
                 Text(description)
                     .font(.body)
                     .foregroundColor(.secondary)
                     .lineLimit(3)
             }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
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
