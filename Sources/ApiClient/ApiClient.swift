import Foundation

public final class ApiClient: Sendable {
    private let session: URLSession
    public static let liveValue = ApiClient(session: .shared)
    public static let testValue = ApiClient(session: .init(configuration: .ephemeral))

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func send<T: BaseRequest>(request: T) async throws -> T.Response {
        do {
            let (data, response) = try await session.data(for: request.buildURLRequest())
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw ApiError.unknown
            }

            return try request.handleResponse(data: data, urlResponse: httpResponse)
        } catch {
            throw ApiError.unknown
        }
    }
}
