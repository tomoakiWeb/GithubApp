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
            name: "WebRepoFeature",
            targets: ["WebRepoFeature"]),
        .library(
            name: "ApiClient",
            targets: ["ApiClient"]),
        .library(
            name: "GithubClient",
            targets: ["GithubClient"]),
        .library(
            name: "ShareModel",
            targets: ["ShareModel"]),
        .library(
            name: "Utility",
            targets: ["Utility"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.15.0"),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", from: "1.4.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "8.1.0"),
    ],
    targets: [
        .target(
            name: "HomeFeature",
        dependencies: [
            "ShareModel",
            "DetailFeature",
            "WebRepoFeature",
            "GithubClient",
            "Kingfisher",
            .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            .product(name: "Dependencies", package: "swift-dependencies"),
        ]),
        .target(
            name: "DetailFeature",
            dependencies: [
                "ShareModel",
                "GithubClient",
                "Kingfisher",
                "Utility",
                "WebRepoFeature",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .target(
            name: "ApiClient"
        ),
        .target(
            name: "GithubClient",
            dependencies: [
                "ApiClient",
                "ShareModel",
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "DependenciesMacros", package: "swift-dependencies")
            ]
        ),
        .target(
            name: "ShareModel"
        ),
        .target(
            name: "Utility"
        ),
        .target(
            name: "WebRepoFeature",
            dependencies: [
                "Utility",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ]
        ),
        .testTarget(
            name: "HomeFeatureTests",
            dependencies: [
                "HomeFeature",
                "ShareModel",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "DetailFeatureTests",
            dependencies: [
                "DetailFeature",
                "ShareModel",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ]
        ),
        .testTarget(
            name: "UtilityTests",
            dependencies: [
                "Utility",
            ]
        )
    ]
)
