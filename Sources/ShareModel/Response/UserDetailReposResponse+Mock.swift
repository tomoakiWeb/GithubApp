#if DEBUG
import Foundation

public extension UserDetailReposResponse {
    
    static func mockArray() -> [UserDetailReposResponse] {
        (0...19).map { i in
            UserDetailReposResponse.mock(
                id: i,
                name: "Repo \(i)",
                fork: i % 2 == 0,
                description: "Description for Repo \(i)",
                stargazersCount: i * 10,
                language: i % 2 == 0 ? "Swift" : "Kotlin",
                htmlUrl: "https://github.com/user/repo\(i)"
            )
        }
    }
    
    static func mockArray2() -> [UserDetailReposResponse] {
        (20...29).map { i in
            UserDetailReposResponse.mock(
                id: i,
                name: "Repo \(i)",
                fork: i % 2 == 0,
                description: "Description for Repo \(i)",
                stargazersCount: i * 10,
                language: i % 2 == 0 ? "Java" : "Javascript",
                htmlUrl: "https://github.com/user/repo\(i)"
            )
        }
    }
    
    static func mockAll() -> [UserDetailReposResponse] {
        mockArray() + mockArray2()
    }
}

#endif

