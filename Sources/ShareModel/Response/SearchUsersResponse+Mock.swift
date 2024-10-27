#if DEBUG
import Foundation

public extension SearchUsersResponse {
    static func mock() -> Self {
        .init(
            totalCount: 10,
            items: [
                .mock(id: 0, login: "Alice"),
                .mock(id: 1, login: "Bob"),
                .mock(id: 2, login: "Charlie"),
                .mock(id: 3, login: "Diana"),
                .mock(id: 4, login: "Eve"),
                .mock(id: 5, login: "Frank"),
                .mock(id: 6, login: "Grace"),
                .mock(id: 7, login: "Hank"),
                .mock(id: 8, login: "Ivy"),
                .mock(id: 9, login: "Jack")
            ]
        )
    }
}
#endif
