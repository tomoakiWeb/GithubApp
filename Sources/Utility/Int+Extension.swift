import Foundation

public extension Int {
    var formattedWithSuffix: String {
        switch self {
        case 1_000_000...:
            let formatted = Double(self) / 1_000_000
            return String(format: "%.1fm", formatted)
        case 1_000...:
            let formatted = Double(self) / 1_000
            return String(format: "%.1fk", formatted)
        default:
            return String(self)
        }
    }
}
