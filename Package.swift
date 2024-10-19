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
    ],
    targets: [
        .target(
            name: "HomeFeature",
        dependencies: [
            "DetailFeature"
        ]),
        .target(
            name: "DetailFeature")
    ]
)
