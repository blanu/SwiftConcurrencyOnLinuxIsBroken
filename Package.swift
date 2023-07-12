// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftConcurrencyOnLinuxIsBroken",
    platforms: [.macOS(.v13)],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftConcurrencyOnLinuxIsBroken",
            targets: ["SwiftConcurrencyOnLinuxIsBroken"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/OperatorFoundation/TransmissionAsync", branch: "main"),
        .package(url: "https://github.com/apple/swift-log", from: "1.5.2"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftConcurrencyOnLinuxIsBroken",
            dependencies: [
            ]
        ),
        .testTarget(
            name: "SwiftConcurrencyOnLinuxIsBrokenTests",
            dependencies: [
                "SwiftConcurrencyOnLinuxIsBroken",
                "TransmissionAsync",
                .product(name: "Logging", package: "swift-log"),
            ]
        ),
    ],
    swiftLanguageVersions: [.v5]
)
