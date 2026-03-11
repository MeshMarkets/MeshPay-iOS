import Foundation

public struct OnRampResource {
    let baseURL: String
    let apiKey: String

    public func getQuote(amountUsd: Double? = nil, amountUsdc: Double? = nil) async throws -> [String: Any] {
        var b: [String: Any] = [:]
        if let v = amountUsd { b["amount_usd"] = v }
        if let v = amountUsdc { b["amount_usdc"] = v }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/on-ramp/quote", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func executeTrade(quoteId: String, idempotencyKey: String? = nil) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["quote_id": quoteId])
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/on-ramp/trade", body: body, idempotencyKey: idempotencyKey)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
