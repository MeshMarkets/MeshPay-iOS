import Foundation

enum JSONUtil {
    static func object(_ data: Data) -> [String: Any] {
        guard !data.isEmpty else { return [:] }
        return (try? JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    static func objectArray(_ data: Data) -> [[String: Any]] {
        guard !data.isEmpty else { return [] }
        if let arr = try? JSONSerialization.jsonObject(with: data) as? [[String: Any]] {
            return arr
        }
        if let obj = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
           let dataArr = obj["data"] as? [[String: Any]] {
            return dataArr
        }
        return []
    }
}
