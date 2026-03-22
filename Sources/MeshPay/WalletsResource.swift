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

    public func listFiatAccounts(membershipId: String) async throws -> [String: Any] {
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "GET", path: "/wallets/fiat-accounts",
            queryItems: [URLQueryItem(name: "membership_id", value: membershipId)], useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func linkFiatAccount(body: [String: Any], idempotencyKey: String) async throws -> [String: Any] {
        let b = try JSONSerialization.data(withJSONObject: body)
        let data = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/wallets/fiat-accounts",
            body: b, idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
        return JSONUtil.object(data)
    }

    public func unlinkFiatAccount(membershipId: String, fiatAccountId: String, idempotencyKey: String) async throws {
        _ = try await HTTPClient.request(
            baseURL: baseURL, apiKey: apiKey, method: "DELETE", path: "/wallets/fiat-accounts",
            queryItems: [
                URLQueryItem(name: "membership_id", value: membershipId),
                URLQueryItem(name: "fiat_account_id", value: fiatAccountId),
            ],
            idempotencyKey: idempotencyKey, useXApiKey: useXApiKey
        )
    }
}
