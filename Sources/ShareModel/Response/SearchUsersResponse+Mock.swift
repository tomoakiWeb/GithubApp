#if DEBUG
import Foundation

public extension SearchUsersResponse {
    static func mock() -> Self {
        .init(
            totalCount: 20,
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
                .mock(id: 9, login: "Jack"),
                .mock(id: 10, login: "Kara"),
                .mock(id: 11, login: "Leo"),
                .mock(id: 12, login: "Mona"),
                .mock(id: 13, login: "Nina"),
                .mock(id: 14, login: "Oscar"),
                .mock(id: 15, login: "Paul"),
                .mock(id: 16, login: "Quinn"),
                .mock(id: 17, login: "Rita"),
                .mock(id: 18, login: "Sam"),
                .mock(id: 19, login: "Tina")
            ]
        )
    }
    
    static func mock2() -> Self {
        .init(
            totalCount: 30,
            items: [
                .mock(id: 20, login: "Uma"),
                .mock(id: 21, login: "Victor"),
                .mock(id: 22, login: "Wendy"),
                .mock(id: 23, login: "Xander"),
                .mock(id: 24, login: "Yara"),
                .mock(id: 25, login: "Zane"),
                .mock(id: 26, login: "Alex"),
                .mock(id: 27, login: "Bella"),
                .mock(id: 28, login: "Carl"),
                .mock(id: 29, login: "Dana"),
            ]
        )
    }
    
    static func mockAll() -> Self {
        .init(
            totalCount: 30,
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
                .mock(id: 9, login: "Jack"),
                .mock(id: 10, login: "Kara"),
                .mock(id: 11, login: "Leo"),
                .mock(id: 12, login: "Mona"),
                .mock(id: 13, login: "Nina"),
                .mock(id: 14, login: "Oscar"),
                .mock(id: 15, login: "Paul"),
                .mock(id: 16, login: "Quinn"),
                .mock(id: 17, login: "Rita"),
                .mock(id: 18, login: "Sam"),
                .mock(id: 19, login: "Tina"),
                .mock(id: 20, login: "Uma"),
                .mock(id: 21, login: "Victor"),
                .mock(id: 22, login: "Wendy"),
                .mock(id: 23, login: "Xander"),
                .mock(id: 24, login: "Yara"),
                .mock(id: 25, login: "Zane"),
                .mock(id: 26, login: "Alex"),
                .mock(id: 27, login: "Bella"),
                .mock(id: 28, login: "Carl"),
                .mock(id: 29, login: "Dana"),
            ]
        )
    }

}
#endif
