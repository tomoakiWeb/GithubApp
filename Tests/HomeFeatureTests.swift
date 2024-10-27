import XCTest
import ComposableArchitecture
import ShareModel

@testable import HomeFeature

@MainActor
class HomeFeatureTests: XCTestCase {
    func testSearchUsersRepos() async {
        let mainQueue = DispatchQueue.test
        let store = TestStore(initialState: HomeReducer.State(),
                              reducer: {
            HomeReducer()
        }, withDependencies: {
            $0.githubClient.searchUsersRepos  = { @Sendable _, _ in .mock() }
            $0.mainQueue = mainQueue.eraseToAnyScheduler()
        })
        
        await store.send(.set(\.query, "t")) {
            $0.query = "t"
            $0.currentPage = 1
            $0.loadingState = .refreshing
        }
        
        await mainQueue.advance(by: .seconds(0.5))
        
        await store.receive(\.searchUserReposResponse.success) {
            $0.items = .init(response: .mock())
            $0.hasMorePage = false
            $0.loadingState = .none
        }
    }
}

