// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "App",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "App",
            targets: ["App"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/FlagsRepository"),
        .package(path: "../../Services/DeepLinkForwarderService"),
        .package(path: "../../Services/OnboardingService"),
        .package(path: "../../Modules/Start"),
        .package(path: "../../Modules/MainTabs"),
        .package(path: "../../Modules/LockedApp")
    ],
    targets: [
        .target(
            name: "App",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "FlagsRepository", package: "FlagsRepository"),
                .product(name: "DeepLinkForwarderService", package: "DeepLinkForwarderService"),
                .product(name: "OnboardingService", package: "OnboardingService"),
                .product(name: "Start", package: "Start"),
                .product(name: "MainTabs", package: "MainTabs"),
                .product(name: "LockedApp", package: "LockedApp")
            ]
        )
    ]
)
