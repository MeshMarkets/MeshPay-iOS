import Foundation

public struct WalletsResource {
    let baseURL: String
    let apiKey: String
    let useXApiKey: Bool

    public func list() async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/wallets", useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func getDetail(membershipId: String, network: String? = nil) async throws -> [String: Any] {
        var items: [URLQueryItem] = []
        if let network = network { items.append(URLQueryItem(name: "network", value: network)) }
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/wallets/\(membershipId)",
            queryItems: items.isEmpty ? nil : items, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }
}
