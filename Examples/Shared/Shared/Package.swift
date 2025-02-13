// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Shared",
    platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16)],
    products: [
        .library(
            name: "Shared",
            targets: ["Shared"]
        )
    ],
    dependencies: [
        .package(path: "../../../../SwiftUINavigation")
    ],
    targets: [
        .target(
            name: "Shared",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation")
            ]
        )

    ]
)
