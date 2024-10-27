public enum ApiError: Error {
    case unknown
    case unacceptableStatusCode(Int)
    case invalidContentType
    case emptyResponse
    case decodingFailed

    public var message: String {
        switch self {
        case .unknown:
            return "不明なエラーが発生しました"
        case .unacceptableStatusCode(let code):
            return "サーバーからエラーが返されました。ステータスコード: \(code)。"
        case .invalidContentType:
            return "無効なコンテンツタイプを受信しました"
        case .emptyResponse:
            return "応答が空でした。後でもう一度お試しください。"
        case .decodingFailed:
            return "データの処理に失敗しました。"
        }
    }
}

