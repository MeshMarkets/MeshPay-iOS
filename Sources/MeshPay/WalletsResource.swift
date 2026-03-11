import Foundation

public struct WalletsResource {
    let baseURL: String
    let apiKey: String

    public func create(accountId: String) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["account_id": accountId])
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/wallets", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func getByAccountId(accountId: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/wallets", queryItems: [URLQueryItem(name: "account_id", value: accountId)])
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
