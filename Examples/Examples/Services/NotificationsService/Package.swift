// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NotificationsService",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "NotificationsService",
            targets: ["NotificationsService"]
        )
    ],
    targets: [
        .target(
            name: "NotificationsService"
        )
    ]
)