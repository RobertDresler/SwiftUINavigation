// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ActionableList",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "ActionableList",
            targets: ["ActionableList"]
        ),
    ],
    dependencies: [
        .package(path: "../../Navigation/ExamplesNavigation"),
        .package(path: "../../Services/Shared"),
        .package(path: "../../Services/FlagsRepository"),
        .package(path: "../../Services/NotificationsService"),
        .package(path: "../../Services/DeepLinkForwarderService"),
        .package(path: "../../Modules/CustomConfirmationDialog"),
        .package(path: "../../Modules/ArchitectureViewOnly"),
        .package(path: "../../Modules/ArchitectureMVVM"),
        .package(path: "../../Modules/ArchitectureComposable"),
        .package(path: "../../Modules/SegmentedTabs")
    ],
    targets: [
        .target(
            name: "ActionableList",
            dependencies: [
                .product(name: "ExamplesNavigation", package: "ExamplesNavigation"),
                .product(name: "Shared", package: "Shared"),
                .product(name: "FlagsRepository", package: "FlagsRepository"),
                .product(name: "NotificationsService", package: "NotificationsService"),
                .product(name: "DeepLinkForwarderService", package: "DeepLinkForwarderService"),
                .product(name: "CustomConfirmationDialog", package: "CustomConfirmationDialog"),
                .product(name: "ArchitectureViewOnly", package: "ArchitectureViewOnly"),
                .product(name: "ArchitectureMVVM", package: "ArchitectureMVVM"),
                .product(name: "ArchitectureComposable", package: "ArchitectureComposable"),
                .product(name: "SegmentedTabs", package: "SegmentedTabs")
            ]
        )
    ]
)
