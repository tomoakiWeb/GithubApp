import XCTest
import ComposableArchitecture
import ShareModel

@testable import DetailFeature

@MainActor
class DetailFeatureTests: XCTestCase {
    func testFetchUserDetail() async {
        let name = "username"
        let store = TestStore(
            initialState: DetailReducer.State(name: name),
            reducer: {
                DetailReducer()
            },
            withDependencies: {
                $0.githubClient.fetchUserDetail = { @Sendable _ in UserDetailResponse.mock() }
                $0.githubClient.fetchUserDetailRepos = { @Sendable _, _ in UserDetailReposResponse.mockArray() }
            }
        )
        
        await store.send(.onAppear) {
            $0.isLoading = true
        }
        
        await store.receive(\.userDetailAndReposFetched) {
            $0.userDetail = UserDetail(from: UserDetailResponse.mock())
            $0.items = .init(responses: UserDetailReposResponse.mockArray())
            $0.isLoading = false
        }
    }
    
    func testPagination() async {
        let name = "username"
        var initialState = DetailReducer.State(name: name)
        initialState.items = .init(responses: UserDetailReposResponse.mockArray())
        initialState.userDetail = .init(from: .mock())
        initialState.hasMorePage = true
        
        let store = TestStore(
            initialState: initialState,
            reducer: {
                DetailReducer()
            },
            withDependencies: {
                $0.githubClient.fetchUserDetailRepos = { @Sendable _, _ in UserDetailReposResponse.mockArray2() }
            }
        )
        
        await store.send(.itemAppeared(id: 19)) {
            $0.currentPage = 2
            $0.hasMorePage = true
        }
        
        await store.receive(\.userDetailReposResponse.success) {
            $0.items = .init(responses: UserDetailReposResponse.mockAll())
        }
        
        await store.send(.itemAppeared(id: 20)) {
            $0.hasMorePage = false
        }
    }
}

