import Foundation

public extension Int {
    var formattedWithSuffix: String {
        switch self {
        case 1_000_000...:
            let formatted = floor(Double(self) / 1_000_000 * 10) / 10
            return String(format: "%.1fm", formatted)
        case 1_000...:
            let formatted = floor(Double(self) / 1_000 * 10) / 10
            return String(format: "%.1fk", formatted)
        default:
            return String(self)
        }
    }
}

