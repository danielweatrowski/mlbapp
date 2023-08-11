// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Standings",
    platforms: [.iOS(.v16)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Standings",
            targets: ["Standings"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Models", path: "../Models"),
        .package(name: "Common", path: "../Common"),

    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Standings",
            dependencies: []),
        .testTarget(
            name: "StandingsTests",
            dependencies: ["Standings"]),
    ]
)
