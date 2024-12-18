import SwiftUI
import Utility
import ComposableArchitecture

public struct WebRepoView: View {
    @Bindable var store: StoreOf<WebRepoReducer>
    
    public init(store: StoreOf<WebRepoReducer>) {
        self.store = store
    }
    
    public var body: some View {
        UIWebView(urlString: store.repoUrl)
    }
}

#Preview {
    WebRepoView(store: .init(initialState: WebRepoReducer.State(repoUrl: "https://www.apple.com/jp/"), reducer: {
        WebRepoReducer()
    }))
}
