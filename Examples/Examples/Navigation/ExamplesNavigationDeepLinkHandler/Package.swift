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
        .package(path: "../../Modules/ModuleA"),
        .package(path: "../../Modules/ModuleB"),
        .package(path: "../../Modules/App"),
        .package(path: "../../Modules/Start"),
        .package(path: "../../Modules/MainTabs")
    ],
    targets: [
        .target(
            name: "ExamplesNavigationDeepLinkHandler",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "ModuleA", package: "ModuleA"),
                .product(name: "ModuleB", package: "ModuleB"),
                .product(name: "App", package: "App"),
                .product(name: "Start", package: "Start"),
                .product(name: "MainTabs", package: "MainTabs")
            ]
        )
    ]
)
