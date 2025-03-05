// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CustomConfirmationDialog",
    platforms: [.iOS(.v16), .macOS(.v13), .macCatalyst(.v16)],
    products: [
        .library(
            name: "CustomConfirmationDialog",
            targets: ["CustomConfirmationDialog"]
        ),
    ],
    dependencies: [
        .package(path: "../../Shared/Shared"),
        .package(path: "../../../../SwiftUINavigation")
    ],
    targets: [
        .target(
            name: "CustomConfirmationDialog",
            dependencies: [
                .product(name: "Shared", package: "Shared"),
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation")
            ]
        )
    ]
)
