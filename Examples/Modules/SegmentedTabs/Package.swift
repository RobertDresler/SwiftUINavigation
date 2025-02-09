// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SegmentedTabs",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "SegmentedTabs",
            targets: ["SegmentedTabs"]
        ),
    ],
    dependencies: [
        .package(path: "../../../../SwiftUINavigation"),
        .package(path: "../../Shared/Shared")
    ],
    targets: [
        .target(
            name: "SegmentedTabs",
            dependencies: [
                .product(name: "SwiftUINavigation", package: "SwiftUINavigation"),
                .product(name: "Shared", package: "Shared")
            ]
        )
    ]
)
