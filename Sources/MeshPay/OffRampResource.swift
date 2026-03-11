import Foundation

public struct OffRampResource {
    let baseURL: String
    let apiKey: String

    public func getQuote(amountUsdc: Double? = nil, amountUsd: Double? = nil) async throws -> [String: Any] {
        var b: [String: Any] = [:]
        if let v = amountUsdc { b["amount_usdc"] = v }
        if let v = amountUsd { b["amount_usd"] = v }
        let body = try JSONSerialization.data(withJSONObject: b)
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/off-ramp/quote", body: body)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }

    public func executeTrade(quoteId: String, idempotencyKey: String? = nil) async throws -> [String: Any] {
        let body = try JSONSerialization.data(withJSONObject: ["quote_id": quoteId])
        let data = try await HTTPClient.request(baseURL: baseURL, apiKey: apiKey, method: "POST", path: "/off-ramp/trade", body: body, idempotencyKey: idempotencyKey)
        return (try JSONSerialization.jsonObject(with: data) as? [String: Any]) ?? [:]
    }
}
