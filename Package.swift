// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "MeshPay",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "MeshPay", targets: ["MeshPay"]),
    ],
    targets: [
        .target(name: "MeshPay", path: "Sources/MeshPay"),
    ]
)
