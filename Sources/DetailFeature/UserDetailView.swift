import SwiftUI
import ComposableArchitecture
import Kingfisher
import ShareModel

struct UserDetailView: View {
    let userDetail: UserDetail

    public var body: some View {
        VStack {
            HStack(spacing: 16) {
                KFImage(userDetail.avatarUrl)
                    .placeholder {
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                    }
                    .resizable()
                    .frame(width: 64, height: 64)
                    .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(userDetail.name)
                        .lineLimit(2)
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    if let fullName = userDetail.fullName {
                        Text(fullName)
                            .lineLimit(2)
                            .font(.body)
                    }
                    
                    HStack(spacing: 4) {
                        Text(String(userDetail.followers))
                        Text("フォロワー")
                            .foregroundStyle(.gray)
                        
                        Text(String(userDetail.following))
                        Text("フォロー中")
                            .foregroundStyle(.gray)
                        Spacer()
                    }
                    .font(.caption)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    UserDetailView(userDetail: .init(from: .mock(id: 1,
                                                 login: "tomo",
                                                 name: "full name",
                                                 followers: 12,
                                                 following: 6)))
}

