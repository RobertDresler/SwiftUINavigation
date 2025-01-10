// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExamplesNavigationDeepLinkHandler",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ExamplesNavigationDeepLinkHandler",
            targets: ["ExamplesNavigationDeepLinkHandler"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Modules/Subscription"),
        .package(path: "../../Services/UserRepository")
    ],
    targets: [
        .target(
            name: "ExamplesNavigationDeepLinkHandler",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "Subscription", package: "Subscription"),
                .product(name: "UserRepository", package: "UserRepository")
            ]
        )
    ]
)
