// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DeepLinkForwarderService",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "DeepLinkForwarderService",
            targets: ["DeepLinkForwarderService"]
        )
    ],
    dependencies: [
        .package(path: "../../../../SwiftUINavigation"),
        .package(path: "../../Navigation/ExamplesNavigation")
    ],
    targets: [
        .target(
            name: "DeepLinkForwarderService",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation")
            ]
        )

    ]
)
