// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GithubApp",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "HomeFeature",
            targets: ["HomeFeature"]),
        .library(
            name: "DetailFeature",
            targets: ["DetailFeature"]),
        .library(
            name: "ApiClient",
            targets: ["ApiClient"]),
        .library(name: "GithubClient",
                 targets: ["GithubClient"]),
        .library(name: "ShareModel",
                 targets: ["ShareModel"])
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
    ],
    targets: [
        .target(
            name: "HomeFeature",
        dependencies: [
            "DetailFeature",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
        ]),
        .target(
            name: "DetailFeature"
        ),
        .target(
            name: "ApiClient"
        ),
        .target(
            name: "GithubClient",
            dependencies: [
                "ApiClient",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "ShareModel"
        )
    ]
)
