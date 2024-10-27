import Foundation

public protocol BaseRequest: Sendable {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var path: String { get }
    var method: String { get }
    var headers: [String: String] { get }
    var queryParameters: [String: String]? { get }
    var decoder: JSONDecoder { get }

    func buildURLRequest() -> URLRequest
    func handleResponse(data: Data, urlResponse: HTTPURLResponse) throws -> Response
}

public extension BaseRequest {
    var method: String { "GET" }
    var headers: [String: String] { [:] }
    var decoder: JSONDecoder { JSONDecoder() }

    func buildURLRequest() -> URLRequest {
        let url =  baseURL.appendingPathComponent(path)
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        if let queryParameters = queryParameters {
            components.queryItems = queryParameters.map { URLQueryItem(name: $0.key, value: "\($0.value)") }
        }

        var request = URLRequest(url: components.url!)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers
        return request
    }

    func handleResponse(data: Data, urlResponse: HTTPURLResponse) throws -> Response {
        guard 200..<300 ~= urlResponse.statusCode else {
            throw ApiError.unacceptableStatusCode(urlResponse.statusCode)
        }
        
        if let contentType = urlResponse.allHeaderFields["Content-Type"] as? String,
           !contentType.contains("application/json") {
            throw ApiError.invalidContentType
        }

        guard !data.isEmpty else {
            throw ApiError.emptyResponse
        }

        do {
            return try decoder.decode(Response.self, from: data)
        } catch {
            throw ApiError.decodingFailed
        }
    }
}

