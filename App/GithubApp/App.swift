import SwiftUI
import HomeFeature

@main
struct GithubApp: App {
    var body: some Scene {
        WindowGroup {
            HomeView(store: .init(initialState: .init()) {
                HomeReducer()
            })
        }
    }
}
