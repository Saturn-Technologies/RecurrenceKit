// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(

    name: "RRule",

    products: [

        .library(
            name: "RRule",
            targets: ["RRule"]
        ),

        .executable(
            name: "Run",
            targets: ["Run"]
        )

    ],

    dependencies: [

        .package(name: "SnapshotTesting",
                 url: "https://github.com/pointfreeco/swift-snapshot-testing.git",
                 from: "1.9.0")

    ],

    targets: [

        .target(
            name: "RRule",
            dependencies: [

            ]
        ),

        .executableTarget(
            name: "Run",
            dependencies: [
                "RRule"
            ]
        ),

        .testTarget(
            name: "RRuleTests",
            dependencies: [
                "RRule",
                "SnapshotTesting"
            ]
        ),

    ]

)
