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
        
        await store.send(.set(\.query, "g")) {
            $0.query = "g"
            $0.currentPage = 1
            $0.loadingState = .refreshing
        }
        
        await mainQueue.advance(by: .seconds(0.1))
        
        await store.send(.set(\.query, "github")) {
            $0.query = "github"
            $0.currentPage = 1
            $0.loadingState = .refreshing
        }
        
        await mainQueue.advance(by: .seconds(0.5))
        
        await store.receive(\.searchUserReposResponse.success) {
            $0.items = .init(response: .mock())
            $0.hasMorePage = false
            $0.loadingState = .none
        }
        
        await store.send(.set(\.query, "")) {
            $0.query = ""
            $0.hasMorePage = false
            $0.items = []
        }
    }
    
    func testPagination() async {
        let mainQueue = DispatchQueue.test
        var initialState = HomeReducer.State()
        initialState.items = .init(response: .mock())
        initialState.hasMorePage = true
        
        let store = TestStore(initialState: initialState) {
            HomeReducer()
        } withDependencies: {
            $0.githubClient.searchUsersRepos  = { @Sendable _, _ in .mock2() }
            $0.mainQueue = mainQueue.eraseToAnyScheduler()
        }

        await store.send(.itemAppeared(id: 19)) {
            $0.currentPage = 2
            $0.loadingState = .loadingNext
        }

        await store.receive(\.searchUserReposResponse.success) {
            $0.items = .init(response: .mockAll())
            $0.hasMorePage = false
            $0.loadingState = .none
        }
    }
}

