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
                throw ApiError.unknown(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid response"]))
            }

            return try request.handleResponse(data: data, urlResponse: httpResponse)
        } catch {
            throw ApiError.unknown(error as NSError)
        }
    }
}

public enum ApiError: Error {
    case unknown(Error)
    case unacceptableStatusCode(Int, message: String)
    case invalidContentType(String)
    case emptyResponse
    case decodingFailed(Error)
}

